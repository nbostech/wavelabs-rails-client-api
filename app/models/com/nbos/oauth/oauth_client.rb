class Com::Nbos::Oauth::OauthClient < ActiveRecord::Base
  self.table_name = "oauth_client"

  #after_initialize :create_activerecord_class


  has_many :oauth_client_scopes , class_name: "Com::Nbos::Oauth::OauthClientScopes"
  has_many :oauth_client_authorities, class_name: "Com::Nbos::Oauth::OauthClientAuthorities"
  has_many :oauth_client_authorized_grant_types, class_name: "Com::Nbos::Oauth::OauthClientAuthorizedGrantTypes"
  has_many :oauth_client_resource_ids, class_name: "Com::Nbos::Oauth::OauthClientResourceIds"
  has_many :oauth_client_redirect_uris, class_name: "Com::Nbos::Oauth::OauthClientRedirectUris"

  private

  #def self.create_activerecord_class table_name
    #associated_class_names = ["oauth_client_scopes",
                              #"oauth_client_authorities",
                              #"oauth_client_authorized_grant_types",
                              #"oauth_client_resource_ids",
                              #"oauth_client_redirect_uris"]
    #associated_class_names.each do |table_name|
      #klass = Class.new(ActiveRecord::Base){self.table_name = table_name}
      #table_name.camelcase
    #end

  #end

end