class Com::Nbos::Client::Api::DataModels::SocialAccountsModel

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