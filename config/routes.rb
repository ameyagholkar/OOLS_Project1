LiveQuestionTool::Application.routes.draw do

  get "admin/newadmin"

  resources :votes
  resources :posts
  resources :users
  resources :system
  resources :sessions , :only => [:login , :create, :logout]
  match "/posts/:id" => "posts#destroy"
  match "/users/:id" => "users#destroy"
  match "/profile" => "users#show"
  match "/liveQuestions" => "system#index"
  match "/system/add_vote" => "system#add_vote"
  match "/system/show" => "system#add_vote"
  match "/system/add_post" => "system#add_post"
  match "/system/add_reply" => "system#add_reply"
  match "/liveQuestions/search" => "system#search"
  #match '/profile' => 'users#show'
  match '/signup' => 'users#new'
  match '/login'  => 'sessions#login'
  match '/logout' => 'sessions#logout'
  match '/newAdmin' => 'admin#new'
  match '/admin' => 'admin#create'
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
   root :to => 'system#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
