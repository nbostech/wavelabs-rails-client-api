class Com::Nbos::Social::SocialController < ApplicationController


 def create
	 api_response = getSocialApi.facebook_login(request.env['omniauth.auth'])
	 render text: api_response
 end	

end
