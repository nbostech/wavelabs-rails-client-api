# This class is a virtual Model for LoginApiModel.
# It have required attributes to create the LoginApiModel object.
# And also it included the Rails ActiveModel::Validations to 
# add errors which will populate on views. Based on the response from
# Wavelabs API server 'add_errors' or 'add_messages' methods add appropriate
# messages to LoginApi model object.

class Com::Nbos::Client::Api::DataModels::LoginApiModel < Com::Nbos::Client::Api::DataModels::BaseApiModel

  attr_accessor :username, :password, :email, :firstName, :lastName, :phone, :newPassword, :message

  def initialize(login_params = nil)
    if login_params.presence
      @username = login_params["username"]
      @password = login_params["password"]
      @email = login_params["email"]
      @firstName = login_params["firstName"]
      @lastName = login_params["lastName"]
      @phone = login_params["phone"]
      @newPassword = login_params["newPassword"]
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
