# This controller is responsible for handling 
# user's sign_up , dash_board, show & edit 
# requests with Wavelabes API Server

class Com::Nbos::Core::UsersController < ApplicationController

  def sign_up
    @login = create_member_sign_up_model
   if request.post?
      binding.pry
     api_response = @identity_api.signup(params[:idn_sdk_ruby_com_nbos_capi_modules_identity_v0_member_signup_model])
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
   if request.get? && params[:uuid].present? 
    api_response = @identity_api.getMemberDetails(session[:member]["uuid"])
    if api_response[:status] == 200
      @member = api_response[:member]
    else
      flash[:notice] = api_response[:message]
    end
   else
     flash[:notice] = "There was a problem with the request or Server. Please logout & ogin again."
   end 
  end

  def edit
    if request.post?
      binding.pry
      user_update_params = params[:idn_sdk_ruby_com_nbos_capi_modules_identity_v0_member_api_model]
      api_response = @identity_api.updateMemberDetails(session[:member]['id'].to_i, user_update_params)
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
      @member = create_member_model(session[:member],false)  
    end  
  end

end