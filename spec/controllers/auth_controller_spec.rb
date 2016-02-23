require "rails_helper"

RSpec.describe Com::Nbos::Core::AuthController, :type => :controller do

  describe "All actions in AuthController" do
  
    let(:valid_login_user) {post :login, :parameters => { :wavelabs_client_api_client_api_data_models_login_api_model => {:username => "test", :password => "test123"}}}
    let(:invalid_login_user) {post :login, :parameters => { :wavelabs_client_api_client_api_data_models_login_api_model => {:username => "abcdtest", :password => "test123"}}}

    it "responds successfully #login" do
      request.host = "http://localhost:3000"
      get :login
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "responds successfully #forgot_password" do
      request.host = "http://localhost:3000"
      get :forgot_password
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "responds for #change_password without login" do
      request.host = "http://localhost:3000"
      get :change_password
      expect(response).to_not be_success 
      expect(response).to have_http_status(302)
    end

    it "responds for #logout without login" do
      request.host = "http://localhost:3000"
      get :logout
      expect(response).to_not be_success 
      expect(response).to have_http_status(302)
    end
    
    it "responds for #login with valid registered user details" do
      request.host = "http://localhost:3000"
      valid_login_user
      expect(response).to be_success 
      expect(response).to have_http_status(200)
    end

    it "responds for #login with unregistered user details" do
      request.host = "http://localhost:3000"
      invalid_login_user
      expect(response).to_not be_success 
      expect(response).to have_http_status(400)
    end

  end
end