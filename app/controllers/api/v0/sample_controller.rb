class Api::V0::SampleController < Api::V0::BaseController
  #before_action :token_authorize!, :except => [:about ]
  before_action :getClientTokenFromHeader, :except => [:about]
  before_action :check_client_token , :only => [:secured_with_client_oAuth]
  before_action :check_oauth_token, :only => [:secured_with_oAuth]
  before_action :check_user_token, :only => [:secured_with_user_oAuth]
  respond_to :json, :xml

  #Swagger-ui Documentation
  swagger_controller :sample, "Sample"

  swagger_api :about do
    summary "Get about Page"
    response :unauthorized
    response :not_acceptable
  end

  swagger_api :secured_with_client_oAuth do
    summary "Get Secured With Client Oauth"
    response :unauthorized
    response :not_acceptable
  end


  # get /about action
  def about
    @obj = { "messageCode": "#{I18n.t(:about_message)}", "message": "#{I18n.t(:about_message_code)}"}
    respond_with(@obj, :status => 200)
  end


  # get /securedWithClientOAuth action
  def secured_with_client_oAuth
    if @token.present? && @token.username == nil
      @status = 200
      @obj = { "message": "Client Authentication success"}
    else
   	  @status = 403
      @obj = { "error": "unauthorized", "error_description": "Full authentication is required to access this resource"}
    end
   respond_with(@obj, :status => @status) and return
  end


  # get /securedWithtOAuth action
  def secured_with_oAuth
    if @token.present?
      @status = 200
      @obj = { "message": "Oauth Authentication success"}
    else
      @status = 403
      @obj = { "error": "unauthorized", "error_description": "Full authentication is required to access this resource"}
    end
    respond_with(@obj, :status => @status) and return
  end

  # get /securedWithtUserOAuth action
  def secured_with_user_oAuth
    if @token.present? && @token.username != nil
      @status = 200
      @obj = { "message": "User Oauth Token Authentication success"}
    else
      @status = 403
      @obj = { "error": "unauthorized", "error_description": "Full authentication is required to access this resource"}
    end
    respond_with(@obj, :status => @status) and return
  end


  private

  # Need to find a way to render response from /lib modules
  def check_client_token
    if !isClientOauth?
      respond_with({ "error": "Invalid Client Token", "error_description": "Full authentication is required to access this resource"}, :status => 403)
    end
  end

  def check_oauth_token
    if !isOauth?
      respond_with({ "error": "Invalid Token", "error_description": "Full authentication is required to access this resource"}, :status => 403)
    end
  end

  def check_user_token
    if !isUserOauth?
      respond_with({ "error": "Invalid User Token", "error_description": "Full authentication is required to access this resource"}, :status => 403)
    end
  end

end	