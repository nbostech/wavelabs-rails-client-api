module Com
  module Nbos
    module Oauth
      module TokenAuthorizer

        def isClientOauth?
          valid_client_oauth_token? ? true : false
        end

        def isOauth?
          authenticate_or_request_with_http_token do |token, options|
            oauth_token = Com::Nbos::Oauth::OauthAccessToken.where(value: token).first
            if oauth_token.presence && oauth_token.accessible?
              return true
            else
              return false
            end
          end
        end

        def isUserOauth?
          valid_user_oauth_token? ? true : false
        end


        def token_authorize!(*scopes)
          valid_oauth_token? ? true : false
        end


        private

        def valid_client_oauth_token?
          authenticate_or_request_with_http_token do |token, options|
            oauth_token = Com::Nbos::Oauth::OauthAccessToken.where(value: token).first
            if oauth_token.presence && oauth_token.username == nil && oauth_token.accessible?
              return true
            else
              return false
            end
          end
        end

        def valid_user_oauth_token?
          authenticate_or_request_with_http_token do |token, options|
            oauth_token = Com::Nbos::Oauth::OauthAccessToken.where(value: token).first
            if oauth_token.presence && oauth_token.username != nil && oauth_token.accessible?
              return true
            else
              return false
            end
          end
        end


        def valid_oauth_token?
          @_oauthkeeper_token ||= Com::Nbos::Oauth::Request.authenticate(request, *methods)
          if @_oauthkeeper_token != nil && @_oauthkeeper_token.accessible?
            return true
          else
            return false
          end
        end

      end
    end
  end
end