class Com::Nbos::Social::SocialController < ApplicationController
 skip_before_action :has_token!

 def create
   #api_response = send_provider_request(params)
	 api_response = getSocialApi.login(request.env['omniauth.auth'], params[:provider])
	 if api_response[:status] == 200 && !api_response[:login].message.present?
	    @member = api_response[:login]
	    create_session(@member)
	    redirect_to :com_nbos_core_dash_board
   else
	    flash[:notice] = api_response[:login].message
	    redirect_to :com_nbos_core_login
   end
 end

end
