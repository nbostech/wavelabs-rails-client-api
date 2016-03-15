class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :get_initial_auth_token

  private

  def get_initial_auth_token
    if WavelabsClientApi::Client::Api::Core::BaseApi.check_connection?
      req = getAuthApi.get_auth_token("client_credentials", [])
      if req[:status] == 200
        @auth_token = req[:token].value.first
      else
        flash[:notice] = req[:token].message
        @auth_token = nil
      end
    else
      flash[:notice] = "The Wavelabs Api server is down please try after sometime."
    end    
  end  

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

  def update_session(member)
    session[:member]["email"] = member.email
    session[:member]["firstName"] = member.firstName
    session[:member]["description"] = member.description
    session[:member]["lastName"] = member.lastName
    session[:member]["phone"] = member.phone
  end 


  def getAuthApi
    WavelabsClientApi::Client::Api::Core::AuthApi.new
  end


  def getUsersApi
    WavelabsClientApi::Client::Api::Core::UsersApi.new
  end

  def getSocialApi
  	WavelabsClientApi::Client::Api::Core::SocialApi.new
  end

  def getMediaApi
    WavelabsClientApi::Client::Api::Core::MediaApi.new
  end 

  
  def create_basic_login_model
   WavelabsClientApi::Client::Api::DataModels::LoginApiModel.new
  end

  def create_member_model(sign_up_params, except_token)
    WavelabsClientApi::Client::Api::DataModels::MemberApiModel.new(sign_up_params, except_token) 
  end

  def create_media_model(media_params)
    WavelabsClientApi::Client::Api::DataModels::MediaApiModel.new(media_params) 
  end

  def check_server_connection!
    if WavelabsClientApi::Client::Api::Core::BaseApi.check_connection?
      true
    else
      flash[:notice] = "The Wavelabs Api server is down please try after sometime."
    end  
  end  

end

