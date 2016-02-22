Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET'], scope: 'public_profile,email', info_fields: 'email,name'
  provider :google_oauth2, ENV['GOOGLE_KEY'], ENV['GOOGLE_SECRET']
  #provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
  provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET']
  provider :linkedin, ENV['LINKEDIN_KEY'], ENV['LINKEDIN_SECRET']
  provider :instagram, ENV['INSTAGRAM_KEY'], ENV['INSTAGRAM_SECRET']
end


OmniAuth.config.on_failure = Proc.new do |env|
  Com::Nbos::Core::AuthController.action(:omniauth_failure).call(env)
  #this will invoke the omniauth_failure action in UsersController.
end