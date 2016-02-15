module Com
  module Nbos
    module Oauth
      class Request
        extend ActionController::HttpAuthentication::Token::ControllerMethods
        module Methods
          def from_authorization_header(request)
            authenticate_or_request_with_http_token do |token, options|
              if Com::Nbos::Oauth::OauthAccessToken.exists?(value: token)
                return token
              else
                return nil
              end
            end
          end

          def from_access_token_param(request)
            request.parameters[:access_token]
          end

          def from_bearer_param(request)
            request.parameters[:bearer_token]
          end

          def from_bearer_authorization(request)
            pattern = /^Bearer /i
            header  = request.authorization
            token_from_header(header, pattern) if match?(header, pattern)
          end

          def from_basic_authorization(request)
            pattern = /^Basic /i
            header  = request.authorization
            token_from_basic_header(header, pattern) if match?(header, pattern)
          end

          private

          def token_from_basic_header(header, pattern)
            encoded_header = token_from_header(header, pattern)
            token, _ = decode_basic_credentials(encoded_header)
            token
          end

          def decode_basic_credentials(encoded_header)
            Base64.decode64(encoded_header).split(/:/, 2)
          end

          def token_from_header(header, pattern)
            header.gsub pattern, ''
          end

          def match?(header, pattern)
            header && header.match(pattern)
          end
        end

        extend Methods

        def self.from_request(request, *methods)
          [:from_bearer_authorization, :from_basic_authorization].inject(nil) do |credentials, method|
            method = self.method(method) if method.is_a?(Symbol)
            credentials = method.call(request)
            break credentials unless credentials.blank?
          end
        end

        def self.authenticate(request, *methods)
          if token = from_request(request, *methods)
            Com::Nbos::Oauth::OauthAccessToken.by_token(token)
          end
        end

      end

    end
  end
end