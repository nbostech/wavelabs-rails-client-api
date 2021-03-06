# This controller is responsible for handling 
# user's get profile picture & upload profile picture
# requests with Wavelabes API Server. 
# This controller will store the uploaded picture into client side
# temporary directory "Rails.root/tmp". After successfull upload into
# Wavelabs Server client side temporary file will be deleted. 

class Com::Nbos::Core::MediaController < ApplicationController
  before_action :has_token!


  def get_media
  	api_response = getMediaApi.get_media(session[:member]["id"], "profile", session[:auth_token])
  	if api_response[:status] == 200
      @media = api_response[:media]
      @file_path = @media.mediaFileDetailsList[1].to_h["mediapath"]
    else
      flash.now[:notice] = api_response[:message].message
      @media = create_media_model(nil)		
    end		
  end
  
  def update_media

    temp_file_path = uploadFile(params[:wavelabs_client_api_client_api_data_models_media_api_model][:newMedia])
    
    api_response = getMediaApi.upload_media(temp_file_path.to_path, "profile", session[:auth_token], session[:member]["id"]) 
    
    if api_response[:status] == 200
      flash[:notice] = api_response[:media].message if api_response[:media].message.present?
      @media = api_response[:media]
      redirect_to :com_nbos_core_get_media
    else
      flash[:notice] = api_response[:message].message
      redirect_to :com_nbos_core_get_media    
    end 

  end

 private 
 
  def uploadFile(file_obj)
    path = Rails.root.join('tmp', file_obj.original_filename)
    File.open(path , 'wb') do |file|
      file.write(file_obj.read)
    end
    return path
  end 

end  