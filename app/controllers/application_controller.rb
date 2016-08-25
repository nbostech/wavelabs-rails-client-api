class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  #before_action :get_initial_auth_token
  before_action :get_identity_module_api

  private

  def get_identity_module_api
    @identity_api = IdnSdkRuby::Com::Nbos::Capi::Modules::Ids::V0::Ids.getModuleApi("identity")
  end   


  def create_session(member)
    session[:auth_token], session[:refresh_token] , session[:member]= nil
    session[:auth_token] = member.token.access_token
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

  
  def create_login_model(name = nil, code = nil)
   IdnSdkRuby::Com::Nbos::Capi::Modules::Identity::V0::LoginModel.new(name, code)
  end

  def create_member_model(member_details = nil, is_new = true)
   IdnSdkRuby::Com::Nbos::Capi::Modules::Identity::V0::MemberApiModel.new(member_details, is_new)
  end

  def create_member_sign_up_model
   IdnSdkRuby::Com::Nbos::Capi::Modules::Identity::V0::MemberSignupModel.new()
  end

  def create_update_password_model(old_pass = nil, new_pass = nil)
   IdnSdkRuby::Com::Nbos::Capi::Modules::Identity::V0::UpdatePasswordApiModel.new(old_pass, new_pass) 
  end 

end

