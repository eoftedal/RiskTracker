Riskmanager::Application.routes.draw do
  
    scope ENV['RAILS_RELATIVE_URL_ROOT'] do 
      resources :projects do
        get 'export',      :on => :member
        get 'tags',        :on => :member
        get 'graph',       :on => :member
        get 'risk_levels', :on => :member

        resources :risk_assets

        resources :risks do
          get 'checklists',      :on => :collection
          get 'assets',          :on => :member
          post 'assign_asset',   :on => :member
          post 'unassign_asset', :on => :member
          resources :comments
          resources :checklists do
            resources :checklist_items
          end
          resources :attachments
        end
      end

      resources :risk_configurations do
      	resources :impacts
      	resources :risk_consequences
      	resources :risk_probabilities
      	resources :risk_levels
        resources :risk_asset_values
      end

      resources :attachments

      resources :users

      resource :changes
      resource :not_approved
      resource :additional_infos
      resource :session

      get  "oauth/new"  => "oauth#new"
      get  "oauth/code" => "oauth#code"

      get  "login"                  => "login#index"
      get  "login/failed"           => "login#failed"
      get  "login/connect"          => "login#connect"
      post "login/connectaccounts"  => "login#connectaccounts"
      get  "login/switch"           => "login#switch"

      get '/auth/:provider/callback' => 'sessions#create'
      match '/auth/failure' => 'sessions#failure'

      root :to => "home#index"
    end

  match "*path" => "home#fix"
  root :to => redirect("/risk/")

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
