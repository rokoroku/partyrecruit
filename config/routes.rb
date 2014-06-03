Rails.application.routes.draw do

  # root 페이지
  root 'static_pages#home'

  # Example of regular route:

  match '/home',    to: 'static_pages#home',    via: 'get'
  match '/help',    to: 'static_pages#help',    via: 'get'
  match '/about',   to: 'static_pages#about',   via: 'get'
  match '/contact', to: 'static_pages#contact', via: 'get'

  match '/signup',  to: 'users#new',            via: 'get'

  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/sessions',to: 'sessions#create',      via: 'post'
  match '/signout', to: 'sessions#destroy',     via: 'delete'

  # Example resource route (maps HTTP verbs to controller actions automatically):
  # resources :sessions,      only: [:new, :create, :destroy]
  resources :microposts #,    only: [:create, :destroy]
  resources :users
  resources :parties

  get '/parties/:id/join', to: 'parties#join', as: 'join_party'
  get '/parties/:id/leave', to: 'parties#leave', as: 'leave_party'
  post '/parties/:id/updatestatus', to: 'parties#update_status', as: 'update_status_for_party'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

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
