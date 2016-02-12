class Com::Nbos::Client::Api::Core::AuthApi < Com::Nbos::Client::Api::BaseApi
  
  # Api Server Authentication End Point URIs
  LOGIN_URI           = "/api/v0/auth/login"
  LOGOUT_URI          = "/api/v0/auth/logout"
  CHANGE_PASSWORD_URI = "/api/v0/auth/changePassword"
  FORGOT_PASSWORD_URI = "/api/v0/auth/forgotPassword"
  RESET_PASSWORD_URI  = "/api/v0/auth/resetPassword"

 
 # Api Call to Change Password request with access_token
 def change_password(change_password_params, access_token)
 	 url_path = base_api_url(CHANGE_PASSWORD_URI)
 	 connection_options = { :password =>  change_password_params[:password],
                          :newPassword => change_password_params[:newPassword]
                        }
   login_model = create_login_model(change_password_params)                     
 	 
   api_response = send_request_with_token('post', url_path, access_token, connection_options.to_json)
   
   begin
     if api_response.code == 400
        login_model.add_errors(api_response.parsed_response)
        { status: 400, login: login_model}
     else
        login_model.add_messages(api_response.parsed_response)
        { status: api_response.code, login: login_model}  
     end
   rescue StandardError
     login_model.message = "Internal Server Error Please Try After Some Time."
     { status: 500, login: login_model}
   end 
 end


 # Api Call to get Reset Password Instructions
 def forgot_password(forgot_password_params)
 	 url_path = base_api_url(FORGOT_PASSWORD_URI)
 	 connection_options = { :email => forgot_password_params[:email] }
 	 api_response = send_request('post', url_path, connection_options)
   login_model = create_login_model(forgot_password_params)
   
   begin
     if api_response.code == 400
        login_model.add_errors(api_response.parsed_response)
        { status: api_response.code, login: login_model}  
     else
        login_model.add_messages(api_response.parsed_response)
        { status: api_response.code, login: login_model} 
     end
   rescue StandardError
     login_model.message = "Internal Server Error Please Try After Some Time."
     { status: 500, login: login_model}
   end 
 end


 # Api Call To Login 
 def login(login_params)
 	 url_path = base_api_url(LOGIN_URI)
 	 connection_options = { :clientId => client_id, 
 	 	                      :username => login_params[:username], 
 	 	                      :password => login_params[:password]
 	 	                    }
   api_response = send_request('post', url_path, connection_options)

   login_model = create_login_model(login_params)
   begin
     if api_response.code == 200
        member_model = create_member_model(api_response.parsed_response, false)
        { status: 200, member: member_model}   
     elsif api_response.code == 400
     	  login_model.add_errors(api_response.parsed_response)
     	  { status: 400, member: nil, login: login_model}
     else
        login_model.add_messages(api_response.parsed_response)
        { status: api_response.code, login: login_model}  
     end
   rescue StandardError
     login_model.message = "Internal Server Error Please Try After Some Time."
     { status: 500, login: login_model}
   end 

 end


 # Api Call To Logout with Access Token
 def logout(access_token)
 	 url_path = base_api_url(LOGOUT_URI)
 	 api_response = send_request_with_token('get', url_path, access_token)
   login_model = create_login_model(nil)
   
   begin
     if api_response.code == 200
       login_model.add_messages(api_response.parsed_response)
       {status: 200, login: login_model}
     else
       login_model.add_messages(api_response.parsed_response)
       {status: api_response.code, login: login_model}
     end
   rescue StandardError
     login_model.message = "Internal Server Error Please Try After Some Time."
     { status: 500, login: login_model}
   end  
 end


 # Need to Implement this based on Server Side Logic
 def reset_password
 	 url_path = base_api_url(RESET_PASSWORD_URI)
 end

end	
