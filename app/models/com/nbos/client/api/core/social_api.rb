# This class is responsible for handling
# Requests from Com::Nbos::Core::SocialController.
# It will create the request based on Controller request params and 
# send that request to Wavelabs API server and return the response back.
# While sending respose back to receiver it will create the virtual models
# from Com::Nbos::Api::DataModels

class Com::Nbos::Client::Api::Core::SocialApi < Com::Nbos::Client::Api::Core::BaseApi

 # Api Server Social Authentication End Point URIs
 FACEBOOK_LOGIN_URI = "/api/v0/auth/social/facebook/connect"
 GOOGLE_LOGIN_URI = "/api/v0/auth/social/googlePlus/connect"
 TWITER_LOGIN_URI = "/api/v0/auth/social/twitter/connect"
 GITHUB_LOGIN_URI = "/api/v0/auth/social/gitHub/connect"
 LINKEDIN_LOGIN_URI = "/api/v0/auth/social/linkedIn/connect"
 INSTAGRAM_LOGIN_URI = "/api/v0/auth/social/instagram/connect"

 

def login(social_params, provider)
  social_uri = get_scoial_login_uri(provider)
  url_path = base_api_url(social_uri)

   connection_options = { :clientId => client_id, 
                          :accessToken => social_params[:credentials][:token], 
                          :expiresIn => "#{social_params[:credentials][:expires_at]}"
                        }
   api_response = send_request('post', url_path, connection_options)
   

   if api_response.parsed_response["message"].present?
     social_member_model = create_member_model(nil, true)
     social_member_model.add_messages(api_response.parsed_response)
   else
     social_member_model = create_member_model(api_response.parsed_response, false)
   end  
  
   begin
     if api_response.code == 200
        { status: 200, login: social_member_model}
     elsif api_response.code == 400
        social_member_model.add_errors(api_response.parsed_response)
        { status: 400, login: social_member_model}
     else
        social_member_model.add_messages(api_response.parsed_response)
        { status: api_response.code, login: social_member_model}  
     end
   rescue StandardError
     social_member_model.message = "Internal Server Error Please Try After Some Time."
     { status: 500, login: social_member_model}
   end

end


# Method to return end point URI for specific social login
def get_scoial_login_uri(provider)
   if provider == "facebook"
     FACEBOOK_LOGIN_URI
   elsif provider == "google_oauth2"
     GOOGLE_LOGIN_URI
   elsif provider == "twitter"
     TWITER_LOGIN_URI
   elsif provider == "github"
     GITHUB_LOGIN_URI
   elsif provider == "linkedin"
     LINKEDIN_LOGIN_URI 
   elsif provider == "instagram"
     INSTAGRAM_LOGIN_URI     
   end  
end  


end	