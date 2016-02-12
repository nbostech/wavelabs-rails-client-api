class Com::Nbos::Client::Api::Core::MediaApi < Com::Nbos::Client::Api::BaseApi

 MEDIA_URI = "/api/v0/media"

 def get_media(user_id, media_for, access_token)
   url_path = base_api_url(MEDIA_URI)
   query_params = { :id => user_id, :mediafor => media_for}
   api_response = send_request_with_token("get", url_path, access_token, nil, query_params)
   
   begin
     if api_response.code == 200
   	   media_model = create_media_model(api_response.parsed_response)
   	   {status: 200, media: media_model}
     end
   rescue StandardError
     message_model = create_message_model(nil)
     message_model.message = "Internal Server Error Please Try After Some Time."
     { status: 500, message: message_model}
   end   	
 end


 def upload_media(file_path, media_for, access_token, user_id)
 	 url_path = base_api_url(MEDIA_URI)
   query_params = { :id => user_id,
                    :mediafor => media_for
                  }

   body = {:file => File.new(file_path)}

   api_response = send_request_with_token("post", url_path, access_token, body, query_params)
   File.delete(file_path)
   begin
     if api_response.code == 200
     	 media_model = create_media_model(api_response.parsed_response)
     	 {status: 200, media: media_model}
     end
    rescue StandardError
      message_model = create_message_model(nil)
      message_model.message = "Internal Server Error Please Try After Some Time."
      { status: 500, message: message_model}
    end   	
 end


end	