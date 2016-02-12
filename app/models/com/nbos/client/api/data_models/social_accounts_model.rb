class Com::Nbos::Client::Api::DataModels::SocialAccountsModel

  attr_accessor :id, :email, :social_type, :image_url

  def initialize(social_params)
    if social_params.presence != nil
      @id = social_params["id"]
      @email = social_params["email"]
      @social_type = social_params["socailType"]
      @image_url = socail_params["imageUrl"]
    else
      @id, @email, @social_type, @image_url = nil
    end
  end

end