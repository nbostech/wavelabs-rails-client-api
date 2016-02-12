class Com::Nbos::Oauth::OauthAccessToken < ActiveRecord::Base
  self.table_name = "oauth_access_token"

  attr_accessible :accessible?, :expired?, :has_scopes?

  has_many :oauth_access_token_scopes, class_name: "Com::Nbos::Oauth::OauthAccessTokenScope"

  # Method to check whether the current
  # Access token is accessible or not by
  # validating the expiration attribute & associated scopes
  def accessible?(*scopes)
    return !expired? && has_scopes?(*scopes)
  end


  # Method to check whether the current
  # Access token is expired or not by
  # validating the expiration attribute
  def expired?
    return self.expiration.to_time < Time.now
  end


  # Method to check whether the current
  # Access token has scopes as passed parameter scopes.
  # If no scopes passed to this method it will check for default "read" scope
  def has_scopes?(*scopes)
    if scopes.presence
      #return self.oauth_access_token_scopes.where()
    else
      return self.oauth_access_token_scopes.where( scope_string: "read").present?
    end
  end

end