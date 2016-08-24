
# This controller is responsible for handling 
# user login ,logout, change_password & forgot_password
# requests with Wavelabes API Server

class Com::Nbos::Core::AuthController < ApplicationController

  def login
    @login = create_login_model
    if request.post?
      loginApiModel = create_login_model(params[:idn_sdk_ruby_com_nbos_capi_modules_identity_v0_login_model][:username],params[:idn_sdk_ruby_com_nbos_capi_modules_identity_v0_login_model][:password])
      api_response = @identity_api.login(loginApiModel)
      if api_response[:status] == 200 
        @member = api_response[:member]
        create_session(@member)
        redirect_to com_nbos_core_user_profile_path(uuid: @member.uuid)
      else
        @login = api_response[:login]
        render :login
      end
    end
  end

  def change_password
    @login = create_update_password_model
    if request.post?
      update_password_model = create_update_password_model(params[:idn_sdk_ruby_com_nbos_capi_modules_identity_v0_update_password_api_model][:password], params[:idn_sdk_ruby_com_nbos_capi_modules_identity_v0_update_password_api_model][:newPassword])
      api_response = @identity_api.updateCredentials(update_password_model)
      if api_response[:status] == 200 || api_response[:status] == 400
        @login = api_response[:login]
      else
        @login = api_response[:login]
      end
    end
  end

  def logout
    api_response = @identity_api.logout
    if api_response[:status] == 200
      flash[:notice] = api_response[:login].message
      clear_session
      redirect_to :com_nbos_core_login
    end
  end

  def forgot_password
    @login = create_basic_login_model
    if request.post?
      api_response = getAuthApi.forgot_password(params[:wavelabs_client_api_client_api_data_models_login_api_model], @auth_token)
      if api_response[:status] == 200
        flash[:notice] = api_response[:login].message + " To #{api_response[:login].email}"
        redirect_to :com_nbos_core_login
      else
        @login = api_response[:login]
        render :forgot_password
      end
    end  
  end

  def omniauth_failure
    flash[:notice] = params
    redirect_to :com_nbos_core_login
  end

end