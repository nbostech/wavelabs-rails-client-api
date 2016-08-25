
class IdsRailsApiContext < IdnSdkRuby::Com::Nbos::Capi::Api::V0::InMemoryApiContext

 def initialize(name = nil, conText = nil)
 	 super(name) if name != nil
 end

 def init()
 end	

 	#CLIENT TOKEN set/get
    def setClientToken(tokenApiModel)
    	super(tokenApiModel)
    end

    def getClientToken
      tokenApiModel = super
      if (tokenApiModel != nil)
        return tokenApiModel
      else
        return nil
      end  
    end

    def setUserToken(moduleName, tokenApiModel)
    	super(moduleName, tokenApiModel)
    end

    def getUserToken(moduleName)
        tokenApiModel = super(moduleName)
        if (tokenApiModel != nil)
          return tokenApiModel
        else
        	return nil    
        end
    end

    def getHost(moduleName)
      host = super(moduleName)
      if host != nil
        return host
      else
        return "http://localhost:8080/"   
      end 
    end

    def setHost(moduleName)
        #Read host name from ENVS
        host = ENV["MODULE_#{moduleName.upcase}_API_HOST_URL"]
        if moduleName != nil && host != nil
          super(moduleName, host)
        else
          super(moduleName, "http://localhost:8080")  
        end
        
    end

    def setClientCredentials(moduleName)
      map = {}
      #Read client credentials from ENVS
      client_key = ENV["MODULE_#{moduleName.upcase}_API_CLIENT_KEY"]
      client_secret = ENV["MODULE_#{moduleName.upcase}_API_CLIENT_SECRET"]
      map["client_id"] = client_key != nil ? client_key :"sample-app-client"
      map["client_secret"] = client_secret != nil ? client_secret :"sample-app-secret"
      super(map)
    end  
end

  app_context = IdsRailsApiContext.new("app")
  app_context.setHost("identity")
  app_context.setClientCredentials("identity")
  IdnSdkRuby::Com::Nbos::Capi::Api::V0::IdnSDK.init(app_context)