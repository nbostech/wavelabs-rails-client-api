require 'httparty'

class Com::Nbos::Oauth::RestClient

  include HTTParty
  debug_output $stdout
  headers 'Accept' => 'application/json', 'Content-Type' => 'application/json'


  def initialize(site_url = nil, options={})
    @site_url = site_url || ENV['API_HOST_URL']
    @client_id = ENV['API_CLIENT_ID']
    @client_secret = ENV['API_CLIENT_SECRET']
  end

  def base_url
    @site_url + "/starter-app-rest-grails/api/v0"
  end

  def build_request_params(action, http_method, option_params = nil)
      case action
        when "login"
          { :url_path => base_url + "/auth/login", :options => { :clientId =>  ENV['API_CLIENT_ID'], :username =>  option_params[:username], :password => option_params[:password] } }
        when "reset_password"
        when "sign_up"
          { :url_path => base_url + "/users/signup", :options => { :clientId =>  ENV['API_CLIENT_ID'],
                                                                   :username =>  option_params[:username],
                                                                   :password => option_params[:password],
                                                                   :email => option_params[:email],
                                                                   :firstName => option_params[:first_name],
                                                                   :lastName => option_params[:last_name]
                                                                 }
          }
        when "forget_password"
        when "change_password"
                  { :url_path => base_url + "/auth/changePassword", :options => { :password =>  option_params[:current_password],
                                                                                  :newPassword => option_params[:new_password]
                                                                                }
                  }
      end
  end

  def send_request(action, http_method, option_params = nil, access_token = nil)

    opt_params = build_request_params(action, http_method, option_params) if option_params != nil

    url_path = opt_params[:url_path].present? ? opt_params[:url_path] : request_url

    if access_token.present?
      server_res = self.class.send(http_method, url_path, :body => opt_params[:options].to_json, :headers => { "Authorization" => "Bearer " + access_token})
    else
      server_res = self.class.send(http_method, url_path, :body => opt_params[:options].to_json)
    end

    return server_res

  end

  def send_get_request(action, access_token)
    server_res = self.class.get(base_url + "/auth/#{action}", :headers => { "Authorization" => "Bearer " + access_token})
  end

  def handle_timeouts
    begin
      yield
    rescue Net::OpenTimeout, Net::ReadTimeout
      {}
    end
  end


end