# This class is a virtual Model for MemberApi model.
# It have required attributes to create the MemberApi model.
# It will create associated TokenApi & SocialAccountsApi model objects based on Response. 
# And also it included the Rails ActiveModel::Validations to 
# add errors which will populate on views. Based on the response from
# Wavelabs API server 'add_errors' or 'add_messages' methods add appropriate
# messages to MemberAPi model object.

class Com::Nbos::Client::Api::DataModels::MemberApiModel < Com::Nbos::Client::Api::DataModels::BaseApiModel

  attr_accessor :id, :username, :description, :email, :firstName, :lastName, :phone, :social_accounts, :token, :message

  def initialize(option_params, except_token = false)
    if option_params.present?
      @id =  option_params["member"]["id"]
      @description = option_params["member"]["description"]
      @email = option_params["member"]["email"]
      @firstName = option_params["member"]["firstName"]
      @lastName = option_params["member"]["lastName"]
      @phone = option_params["member"]["phone"]
      build_associated_models(option_params["token"], option_params["member"]["socialAccounts"], except_token)
    end
  end

  def build_associated_models(token_params, social_params, except_token)
    @token = create_token_model(token_params) if !except_token
    @social_accounts = []
    if social_params.presence && social_params.size > 0
      social_params.each do |sp|
        @social_accounts << create_social_model(sp)
      end
    else
      @social_accounts << create_social_model(nil)
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