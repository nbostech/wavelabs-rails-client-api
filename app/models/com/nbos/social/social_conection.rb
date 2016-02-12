class Com::Nbos::Social::SocialConnection < ActiveRecord::Base
  self.table_name = 'social_connection'

  belongs_to :login, class_name: "Come::Nbos::Core::Login"
end