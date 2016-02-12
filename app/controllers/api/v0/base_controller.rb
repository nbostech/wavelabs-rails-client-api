class Api::V0::BaseController < ApplicationController

  #skip_before_filter :verify_authenticity_token, :if => Proc.new { |c| c.request.format == 'application/json' }


  before_action :set_default_response_format, :set_locale



  # Before Filter to set the locale
  # Which means if the request header have the "HTTP_ACCEPT_LANGUAGE"
  # Then the locale will be set based on that value.
  # Otherwise It will set default value form application configuration
  def set_locale
    I18n.locale = extract_locale_from_accept_language_header.to_s.downcase.presence || I18n.default_locale
  end


  # Before Filter to set the response type.
  def set_default_response_format
    formats = ['application/json', 'application/xml']
    if (params[:format].nil? && !formats.include?(request.format.to_str))
      request.format = 'json'.to_sym
    end
  end

  private

  # Before Filter to get the token from Request header.
  def getClientTokenFromHeader
    authenticate_or_request_with_http_token do |token, options|
      if Com::Nbos::Oauth::OauthAccessToken.exists?(value: token)
        @token = Com::Nbos::Oauth::OauthAccessToken.where(value: token).first
        return @token
      else
        return @token = nil
      end
    end
  end

  def extract_locale_from_accept_language_header
    request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first if request.env['HTTP_ACCEPT_LANGUAGE'].present?
  end

end