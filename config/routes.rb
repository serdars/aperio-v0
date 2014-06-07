Rails.application.routes.draw do
  root 'global#home'

  resources :user_sessions, only: [ :create ]
  resources :users, only: [ :new, :create, :show ]
  delete '/logout' => 'user_sessions#destroy', as: :logout

  resources :organizations, only: [ :show ]
  get   '/organizations/:id/manage' => 'organizations#manage', as: :organization_manage
  post  '/organizations/:id/join' => 'organizations#join', as: :organization_join
  # We redirect GET on join to show to satisfy user_required use case.
  get   '/organizations/:id/join' => 'organizations#show'

  resources :groups, only: [ :show ]
  post  '/groups/:id/join' => 'groups#join', as: :group_join
  # We redirect GET on join to show to satisfy user_required use case.
  get   '/groups/:id/join' => 'groups#show'

  post 'notify' => 'notifications#notify', as: :notify

  resources :conversations, only: [ :show, :new, :create, :destroy ]
  post '/conversations/:id/post' => 'conversations#post', as: :conversation_post

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
