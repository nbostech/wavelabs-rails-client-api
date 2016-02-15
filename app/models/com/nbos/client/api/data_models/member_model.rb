class Com::Nbos::Client::Api::DataModels::MemberModel

  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

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
    @token = Com::Nbos::Client::Api::DataModels::TokenModel.new(token_params) if !except_token
    @social_accounts = []
    if social_params.presence && social_params.size > 0
      social_params.each do |sp|
        @social_accounts << Com::Nbos::Client::Api::DataModels::SocialAccountsModel.new(sp)
      end
    else
      @social_accounts << Com::Nbos::Client::Api::DataModels::SocialAccountsModel.new(nil)
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