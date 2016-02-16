# This class is responsible for handling
# Requests from Com::Nbos::Core::UsersController.
# It will create the request based on Controller request params and 
# send that request to Wavelabs API server and return the response back.
# While sending respose back to receiver it will create the virtual models
# from Com::Nbos::Api::DataModels

class Com::Nbos::Client::Api::Core::UsersApi < Com::Nbos::Client::Api::Core::BaseApi

  SIGNUP_URI = "/api/v0/users/signup"
  USER_URI = "/api/v0/users"
  
 def sign_up(sign_up_params)
 	 url_path = base_api_url(SIGNUP_URI)
 	 connection_options = { :clientId  =>  client_id,
                          :username  =>  sign_up_params[:username],
                          :password  =>  sign_up_params[:password],
                          :email     =>  sign_up_params[:email],
                          :firstName =>  sign_up_params[:firstName],
                          :lastName  =>  sign_up_params[:lastName]
                        }                   
   api_response = send_request('post', url_path, connection_options)
   
   new_member_model =  create_login_model(sign_up_params)
   
   begin
     if api_response.code == 200
       member_api_model = create_member_model(api_response.parsed_response, false)
       {status: 200, member: member_api_model}
     elsif api_response.code == 400
       new_member_model.add_errors(api_response.parsed_response)
       {status: api_response.code, member: new_member_model}
     else
       new_member_model.add_messages(api_response.parsed_response)
       {status: api_response.code, member: new_member_model}  
     end
   rescue StandardError
     new_member_model.message = "Internal Server Error Please Try After Some Time."
     { status: 500, member: new_member_model}
   end  

 end

 def show(user_params, access_token)
 	 url_path = base_api_url(USER_URI + "/#{user_params[:id]}")
 	 api_response = send_request_with_token('get', url_path, access_token)
   begin
     if api_response.code == 200
       normalized_res = {"member" => api_response.parsed_response}
       {status: 200, member: create_member_model(normalized_res, true)}
     else
       login_model = create_login_model(nil)
       login_model.add_messages(api_response.parsed_response)
       { status: api_response.code, member: login_model}  
     end
   rescue StandardError
     login_model = create_login_model(nil)
     login_model.message = "Internal Server Error Please Try After Some Time."
     { status: 500, member: login_model}
   end   
 end

 def update(user_params, access_token)
 	 url_path = base_api_url(USER_URI + "/#{user_params[:id]}")
 	 connection_options = { 
                          :email     =>  user_params[:email],
                          :firstName =>  user_params[:firstName],
                          :lastName  =>  user_params[:lastName],
                          :description => user_params[:description],
                          :phone => user_params[:phone]
                        }
   api_response = send_request_with_token('put', url_path, access_token, connection_options.to_json)
    
   begin 
     if api_response.code == 200
       normalized_res = {"member" => api_response.parsed_response}
       {status: 200, member: create_member_model(normalized_res, true)}
     elsif api_response.code == 400
       member_model = create_member_model({"member" => user_params}, true)
       member_model.add_errors(api_response.parsed_response)
       {status: 400, member: member_model}
     end
   rescue StandardError
     member_model = create_member_model(nil, true)
     member_model.message = "Internal Server Error Please Try After Some Time."
     { status: 500, member: member_model}
   end                           
 end	

end	