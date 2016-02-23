# This controller is responsible for handling 
# user's sign_up , dash_board, show & edit 
# requests with Wavelabes API Server

class Com::Nbos::Core::UsersController < ApplicationController

  before_action :has_token!, :except => [:sign_up]

  def sign_up
    @login = create_basic_login_model
   if request.post?
     api_response = getUsersApi.sign_up(params[:wavelabs_client_api_client_api_data_models_login_api_model], @auth_token)
      if api_response[:status] == 200
        @login = api_response[:member]
        create_session(@login)
        redirect_to :com_nbos_core_dash_board
      else 
        @login = api_response[:member]
        render :sign_up
      end
   end
  end

  def dash_board
    # Need to implement the dashboard page 
  end  

  def show
   if request.get? && params[:id].present? 
    user_show_params = params
    api_response = getUsersApi.show(user_show_params, session[:auth_token])
    if api_response[:status] == 200
      @member = api_response[:member]
    else
      @login = api_response[:member]
    end
   else
     flash[:notice] = "There was a problem with the request or Server. Please logout & ogin again."
   end 
  end

  def edit
    if request.post?
      user_update_params = params[:wavelabs_client_api_client_api_data_models_member_api_model]
      api_response = getUsersApi.update(user_update_params, session[:auth_token])
      if api_response[:status] == 200
        flash.now[:notice] = "Your Profile has been updated successfully."
        @member = api_response[:member]
        update_session(@member)
        render :show
      elsif api_response[:status] == 400
        @member = api_response[:member]
        render :edit
      else
        @member = create_member_model({"member" => user_update_params}, true)  
        @member.message = api_response[:member].message
        render :edit
      end
    else
      @member = create_member_model({"member" => session[:member]},false)  
    end  
  end

end