
# This controller is responsible for handling 
# user login ,logout, change_password & forgot_password
# requests with Wavelabes API Server

class Com::Nbos::Core::AuthController < ApplicationController
  
  before_action :has_token!, :except => [:login, :forgot_password]
  before_action :check_server_connection!, :only => [:login]

  def login
    @login = create_basic_login_model
    if request.post?
      api_response = getAuthApi.login(params[:wavelabs_client_api_client_api_data_models_login_api_model])
      if api_response[:status] == 200
        @member = api_response[:member]
        create_session(@member)
        redirect_to :com_nbos_core_dash_board
      else
        @login = api_response[:login]
        render :login
      end
    end
  end

  def change_password
    @login = create_basic_login_model
    if request.post?
      api_response = getAuthApi.change_password(params[:wavelabs_client_api_client_api_data_models_login_api_model], session[:auth_token])
      if api_response[:status] == 200 || api_response[:status] == 400
        @login = api_response[:login]
      else
        @login = api_response[:login]
      end
    end
  end

  def logout
    api_response = getAuthApi.logout(session[:auth_token])
    if api_response[:status] == 200
      flash[:notice] = api_response[:login].message
      clear_session
      redirect_to :com_nbos_core_login
    end
  end

  def forgot_password
    @login = create_basic_login_model
    if request.post?
      api_response = getAuthApi.forgot_password(params[:wavelabs_client_api_client_api_data_models_login_api_model])
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