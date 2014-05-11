Mapman::Application.routes.draw do
  #resources :maps
  
  
  match 'maps/updateRoute/:id/:color/:num/:dis(/:description)', to: 'maps#updateRoute', constraints: {description: /.*/} #/ periods
  match 'maps/updateColor(/:id/:color)', to: 'maps#updateColor'
  match 'maps/updateRouteNum(/:id/:num)', to: 'maps#updateRouteNum'
  match 'maps/randomRoute/:id/:lat/:long(/:num)', to: 'maps#randomRoute', constraints: {lat: /.*/, long: /.*/} #/ periods
  match 'maps/savePoi/:id/:type/:lat/:long/:height/:name', to: 'maps#savePoi', constraints: {lat: /.*/, long: /.*/} #/ periods
  match 'maps/deletePoi/:id', to: 'maps#deletePoi'
  match 'maps/addNewPoi/:lat/:long/:type/:height/:park/:name(/:desc)', to: 'maps#addNewPoi', constraints: {lat: /.*/, long: /.*/, desc: /.*/} #/ periods
  
  match 'maps/:id(/:data)', to: 'maps#showMap'
  match 'editroute/:id/:lat/:long', to: 'editroute#breakRoute', constraints: {lat: /.*/, long: /.*/} #/ periods
  match 'editroute/:id', to: 'editroute#showRoute'
  
	#match 'maps/:id', to: 'maps#show'
	
	resources :pois
	resources :parks
	resources :routes
	resources :pairs
	resources :nodes
	resources :park_aliases
	resources :poi_types
	
	
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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
