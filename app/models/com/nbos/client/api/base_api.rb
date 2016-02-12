require 'httmultiparty'

class Com::Nbos::Client::Api::BaseApi

 include HTTMultiParty
 
 debug_output $stdout

 headers 'Accept' => 'application/json', 'Content-Type' => 'application/json'
 
 def base_api_url(uri)
 	 site_url + uri
 end
 	
 def site_url
   ENV['API_HOST_URL']	
 end

 def client_id
   ENV['API_CLIENT_ID']
 end

 def client_secret
   ENV['API_CLIENT_SECRET']	
 end

 def self.check_connection?
   begin 
	   res = self.get(ENV['API_HOST_URL'])
	   if res.code == 200
	   	true
	   end
	 rescue StandardError
      false
    end   	  	
 end	

 def send_request_with_token(method, url, access_token, body = nil, query = nil)
 	
 	 begin
 	  self.class.send(method, url, :body => body, :query => query, :headers => {"Authorization" => "Bearer " + access_token})
   rescue StandardError
   end

 end

 def send_request(method, url, body = nil)
 	begin
 	 self.class.send(method, url, :body => body.to_json)
  rescue StandardError
  end

 end 

 def create_login_model(login_params)
 	 Com::Nbos::Client::Api::DataModels::LoginModel.new(login_params)
 end

 def create_member_model(json_response, except_token)
   Com::Nbos::Client::Api::DataModels::MemberModel.new(json_response, except_token)
 end

 def create_media_model(json_response)
   Com::Nbos::Client::Api::DataModels::MediaApiModel.new(json_response)	
 end

 def create_message_model(json_response)	
   Com::Nbos::Client::Api::DataModels::MessageApiModel.new(json_response)	
 end

end	
