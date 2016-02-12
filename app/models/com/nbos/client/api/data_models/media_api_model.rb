class Com::Nbos::Client::Api::DataModels::MediaApiModel
 include ActiveModel::Validations
 include ActiveModel::Conversion
 extend ActiveModel::Naming

  attr_accessor :extension, :mediaFileDetailsList, :supportedsizes, :newMedia, :message

  def initialize(media_params = nil)
  	if media_params.present? && media_params["extension"].present?
	  	@extension = media_params["extension"]
	  	@mediaFileDetailsList = media_params["mediaFileDetailsList"]
	  	@supportedsizes = media_params["supportedsizes"]
	  elsif media_params.present? && media_params["message"].present?
	    @message = media_params["message"]	
	  end	
  end

end	
