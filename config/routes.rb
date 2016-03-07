Rails.application.routes.draw do
  get 'static_pages/games'
  get 'static_pages/credits'
  get 'static_pages/help'
  get 'games/new'
  get 'games/load'


  get 'games/index'

  get 'games/query'

  post 'games/query'

  post 'games/create'

  get  '/query' , to:'games#query', as:"query"



  get 'sessions/new'

  get 'sessions/destroy'

  post '/sessions/create', to: 'sessions#create', as:'login_submit_path'

  post '/sessions/new', to: 'sessions#new'


  get 'users/new'

  get 'users/log_out_user'

  post 'users/create'

  get 'users/home', to:'users#home', as: 'users_home_path'

  root 'users#new'


  get 'users/home', to: 'users#home'


  get 'demo/index'
  post 'demo/new_game'
  post 'demo/index'
  get 'demo/user_input'
  
  get 'medical/index'
  post 'medical/new_game'
  post 'medical/index'
  get 'medical/user_input'

  get 'sprained_ankle/index'
  post 'sprained_ankle/new_game'
  post 'sprained_ankle/index'
  post 'sprained_ankle/watson_question'


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
end
