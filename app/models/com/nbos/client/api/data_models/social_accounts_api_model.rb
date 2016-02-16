# This class is a virtual Model for SocialAccountsApiModel.
# It have required attributes to create the SocialAccountsApiModel object.
# And also it included the Rails ActiveModel::Validations to 
# add errors which will populate on views. Based on the response from
# Wavelabs API server 'add_errors' or 'add_messages' methods add appropriate
# messages to SocialAccountsApiModel object.

class Com::Nbos::Client::Api::DataModels::SocialAccountsApiModel < Com::Nbos::Client::Api::DataModels::BaseApiModel

  attr_accessor :id, :email, :social_type, :image_url

  def initialize(social_params)
    if social_params.presence
      @id = social_params["id"]
      @email = social_params["email"]
      @social_type = social_params["socialType"]
      @image_url = social_params["imageUrl"]
    else
      @id, @email, @social_type, @image_url = nil
    end
  end


  def add_errors(json_response)
    json_response["errors"].each do |e| 
      property_name = e['propertyName']
      msg = e['message']  
      self.errors[property_name] << msg
    end   
  end

  def add_messages(json_response)
    if json_response["message"].present?
      @message = json_response["message"]
    elsif json_response["error"].present?
      @message = json_response["error"]
    end  
          
  end

end