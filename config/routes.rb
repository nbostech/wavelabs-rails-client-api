Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

    # API Server Related Routes
    namespace :api , :path => "/starter-app-rest-rails/api" do
      namespace :v0, :path => "/v0/sample"do
        get 'about' => 'sample#about', :path => '/about'
        get 'securedWithClientOAuth' => 'sample#secured_with_client_oAuth', :path => '/securedWithClientOAuth'
        get 'securedWithOAuth' => 'sample#secured_with_oAuth', :path => '/securedWithOAuth'
        get 'securedWithUserOAuth' => 'sample#secured_with_user_oAuth', :path => '/securedWithUserOAuth'
      end

      namespace :v0, :path => "/v0/oauth" do
        get 'token' => 'oauth#token_authorizer', :path => '/token_authorizer'
        get 'token' => 'oauth#token', :path => '/token'
      end

    end

    # Client UI Related Routes
    namespace :com, :path => nil do
      namespace :nbos, :path => nil do
        namespace :core, :path => nil do
           get "/" => "auth#login"
           match 'login' => "auth#login", as: 'login', via: [:get, :post]
           match 'sign_up' => "users#sign_up", as: 'sign_up', via: [:get, :post]
           get 'user_profile' => "users#show", as: 'user_profile'
           match 'users' => "users#edit", as: 'edit', via: [:get, :post]
           get 'dash_board' => "users#dash_board", as: 'dash_board'
           match 'change_password' => "auth#change_password", as: 'change_password', via: [:get, :post]
           match 'forgot_password' => "auth#forgot_password", as: 'forgot_password', via: [:get, :post]
           get 'logout' => "auth#logout", as: 'logout'
           get 'get_media' => "media#get_media", as: 'get_media'
           put 'update_media' => "media#update_media", as: 'update_media'
        end  
      end
    end

    # Social Login Routes
    namespace :com, :path => nil do
      namespace :nbos, :path => nil do
        namespace :social, :path => nil do
          get '/auth/:provider/callback' => "social#create"
        end  
      end
    end 
      
end
