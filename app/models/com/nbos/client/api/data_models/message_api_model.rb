class Com::Nbos::Client::Api::DataModels::MessageApiModel

  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :status, :messgeCode, :message

  def initialize(json_response)
  	if json_response.present?
	  	@status = json_response.code 
	  	@messageCode = json_response.parsed_response[:messageCode]
	  	@message = json_response.parsed_response[:message]
	  end	
  end

end	