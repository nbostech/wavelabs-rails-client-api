class ApplicationController < ActionController::Base
  include Com::Nbos::Oauth::TokenAuthorizer
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :check_server_connection!


  private

  def has_token!
  	if session[:auth_token].presence 
  		if valid_token?
        true
      else
        flash[:notice] = "Your session has been expired please login again."
        redirect_to :com_nbos_core_login
      end  
  	else
  		flash[:notice] = "Login Required To Use The Service."
  		redirect_to :com_nbos_core_login
  	end	
  end

  def valid_token?
    if session[:logged_in_time].to_time + session[:member]["token"]["expires_in"] > Time.now
      true
    else
      clear_session
      false
    end  
  end  


  def create_session(member)
    session[:auth_token], session[:refresh_token] , session[:member]= nil
    session[:auth_token] = member.token.value.first
    session[:refresh_token] = member.token.refresh_token
    session[:member] = member
    session[:logged_in_time] = Time.now
  end 

  def clear_session
    session[:auth_token], session[:refresh_token] , session[:member], session[:logged_in_time]= nil
  end 


  def getAuthApi
    Com::Nbos::Client::Api::Core::AuthApi.new
  end


  def getUsersApi
    Com::Nbos::Client::Api::Core::UsersApi.new
  end

  def getSocialApi
  	Com::Nbos::Client::Api::Core::SocialApi.new
  end

  def getMediaApi
    Com::Nbos::Client::Api::Core::MediaApi.new
  end 

  def create_member_model(sign_up_params, except_token)
    Com::Nbos::Client::Api::DataModels::MemberModel.new(sign_up_params, except_token) 
  end

  def create_media_model(media_params)
    Com::Nbos::Client::Api::DataModels::MediaApiModel.new(media_params) 
  end

  def check_server_connection!
    if Com::Nbos::Client::Api::BaseApi.check_connection?
      true
    else
      flash[:notice] = "The Wavelabs Api server is down please try after sometime."
    end  
  end  

end

