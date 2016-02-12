class Api::V0::OauthController < Api::V0::BaseController
  before_action :getClientTokenFromHeader, :only => [:token_authorizer]
  respond_to :json, :xml


  def token_authorizer
    if @token.presence && @token.accessible?
      @status = 200
      @obj = { "message": "Token Authentication success", "messageCode": "Success"}
    else
      @status = 403
      error_description = get_token_error_message(@token)
      @obj = { "error": "Invalid Token", "error_description": error_description}
    end
    respond_with(@obj, :status => @status) and return
  end



  def token
   if request.query_string.presence
     if params[:grant_type] == "client_credentials"
       @obj, @status = process_client_credentials(params)
     end
   else
     @status = 404
     @obj = { "error": "Invalid Info", "error_description": "Invalid request parameters"}
   end
   respond_with(@obj, :status => @status) and return
  end

  private

  def process_client_credentials(params)
    client_id = params[:client_id] if params[:client_id].presence
    client_secret = params[:client_secret] if params[:client_secret].presence
    client_scope = params[:scope].split(",") if params[:scope].presence
    oauth_client = Com::Nbos::Oauth::OauthClient.where(client_id: client_id, client_secret: client_secret).first
    if oauth_client.presence
      oauth_token = Com::Nbos::Oauth::OauthAccessToken.where(client_id: oauth_client)
      #obj = { "token":  }
    else
    end
  end

  def get_token_error_message(token)
    @token.presence ? @token.expired? ? "Token Was Expired" : "Token Authority issue" : "Need A Token to authorize"
  end

end