# Wavelabs Rails Client

  This is an example application to demonstarte how to use 'wavelabs_client_api' library using Ruby On Rail framework. This application using following major gems:

        # For OAuth protocal 
        gem 'omniauth-oauth2', '~> 1.3.1'

	# For Login with Facebook 
	gem 'omniauth-facebook'
	
	# For Login with Google +
	gem 'omniauth-google-oauth2'
	
	# For Login with github
	gem 'omniauth-github'
	
	# For Login with linkedin
	gem 'omniauth-linkedin-oauth2'
	
	# For Login with Instagram
	gem 'omniauth-instagram'
	
	# Run time dependent for wavelabs_client_api gem
	gem 'httmultiparty'
	
	# For using icons in views
	gem "font-awesome-rails"
	
	# For Environment variables
	gem "figaro"


	Gemfile contains all the required gems list. No need to worry about gems list 'bundle install' will install all the gems. Live application is available on heroku https://wavelabs-rails-client-api.herokuapp.com  

## Ruby & Rails versions

  1. Ruby 2.2.3
  
  2. Rails 4.2.4

  You can install required versions of ruby, rails & gemsets using rvm(ruby version manager) https://rvm.io/

## Configuration Instructions
 
   After installing Ruby & Rails from your console follow the steps:

  1. git clone https://github.com/nbostech/wavelabs-rails-client-api.git

  2. cd wavelabs-rails-client-api

  2. bundle install

  3. bundle exec figaro install

  4. Above comand will create a file called 'application.yml' file. Open that file in your favorite editor and add the following environment variables.

    ## WaveLabs Server Details 
   
    API_HOST_URL: 'http://111.93.2.105:8080/starter-app-rest-grails'
    
    API_CLIENT_KEY: 'my-client'
    
    API_CLIENT_SECRET: 'my-secret' 
    
    
    ## Social Login Details
    
    FACEBOOK_KEY: 'FACEBOOK APP KEY'
    
    FACEBOOK_SECRET: 'FACEBOOK APP SECRET'

    GOOGLE_KEY: 'GOOGLE APP KEY'
    GOOGLE_SECRET: 'GOOGLE APP SECRET'

    GITHUB_KEY: 'GITHUB APP KEY'
    
    GITHUB_SECRET: 'GITHUB APP SECRET'

    LINKEDIN_KEY: 'LINKEDIN APP KEY'
    
    LINKEDIN_SECRET: 'LINKEDIN APP SECRET'

    INSTAGRAM_KEY: 'INSTAGRAM APP KEY'
    
    INSTAGRAM_SECRET: 'INSTAGRAM APP KEY'


    Note: You can use above Wavelabs Server details. It's public. And you need to create your own apps for social logins & modify social login details.

    After adding appropriate details save & close the file.

  5. rails server

  6. Open the link http://localhost:3000 in any browser.

  7. Now you are ready to use the web application.  


## To-Do

 Need to add test cases.


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/wavelabs-rails-client-api. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

