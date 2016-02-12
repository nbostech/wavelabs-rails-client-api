class Com::Nbos::Client::Api::DataModels::LoginModel

  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

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
