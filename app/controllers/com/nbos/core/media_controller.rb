# This controller is responsible for handling 
# user's get profile picture & upload profile picture
# requests with Wavelabes API Server. 
# This controller will store the uploaded picture into client side
# temporary directory "Rails.root/tmp". After successfull upload into
# Wavelabs Server client side temporary file will be deleted. 

class Com::Nbos::Core::MediaController < ApplicationController
  before_action :get_media_api

  def get_media
  	api_response = @media_api.getMedia(session[:member]["uuid"], "profile")
  	if api_response[:status] == 200
      @media = api_response[:media]
      @file_path = api_response[:media].mediaFileDetailsList[1].mediapath
    else
      flash.now[:notice] = api_response[:message].message
      @media = create_media_model(nil)		
    end		
  end
  
  def update_media
    temp_file_path = uploadFile(params[:idn_sdk_ruby_com_nbos_capi_modules_media_v0_media_api_model][:newMedia])
    
    api_response = @media_api.uploadMedia(session[:member]["uuid"], "profile",temp_file_path.to_path) 
    
    if api_response[:status] == 200
      flash[:notice] = api_response[:media].message.present? ? api_response[:media].message : "Media Updated Successfully"
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

  def get_media_api
    @media_api = IdnSdkRuby::Com::Nbos::Capi::Modules::Ids::V0::Ids.getModuleApi("media")
  end  

end  