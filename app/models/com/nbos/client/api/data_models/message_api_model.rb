# This class is a virtual Model for MessageApi model.
# It have required attributes to create the MessageApi model object.
# The purpose of this class is to create MessageApi model object
# to send back the API Server response. 


class Com::Nbos::Client::Api::DataModels::MessageApiModel

  attr_accessor :status, :messgeCode, :message

  def initialize(json_response)
  	if json_response.present?
	  	@status = json_response.code 
	  	@messageCode = json_response.parsed_response[:messageCode]
	  	@message = json_response.parsed_response[:message]
	  end	
  end

end	