class Com::Nbos::Client::Api::Core::SocialApi < Com::Nbos::Client::Api::BaseApi

 # Api Server Social Authentication End Point URIs
 FACEBOOK_LOGIN_URI = "/api/v0/auth/social/facebook/connect"

 def facebook_login(social_params)
   url_path = base_api_url(FACEBOOK_LOGIN_URI)

   connection_options = { :clientId => client_id, 
 	 	                      :accessToken => social_params[:credentials][:token], 
 	 	                      :expiresIn => "#{social_params[:credentials][:expires_at]}"
 	 	                    }
   server_res = send_request('post', url_path, connection_options)
 end

end	