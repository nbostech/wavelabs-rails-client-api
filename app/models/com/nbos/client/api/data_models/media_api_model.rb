# This class is a virtual Model for MediaApi model.
# It have required attributes to create the MediaApi model.
# And also it included the Rails ActiveModel::Validations to 
# add errors which will populate on views. Based on the response from
# Wavelabs API server aading appropriate
# message to MediaApi model object w hile initialize.


# To-Do
# Right now we are getting 200 status code for invalid file formates
# Need to Cahnge the logic based on API server.
class Com::Nbos::Client::Api::DataModels::MediaApiModel < Com::Nbos::Client::Api::DataModels::BaseApiModel

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
