Devise::Application.routes.draw do


  # get "users/admin_page"
  # get "users/user_page"
  #

  devise_for :users ,  :controllers => {:registrations => "users/registrations",:sessions=>"users/sessions",:passwords=>"users/passwords"}
  root :to=>"users#admin_page"
  devise_scope :user do
    get "/login" => "devise/sessions#new"
    get "/logout" => "devise/sessions#destroy"
    get "/signup"=>"devise/registrations#new"
    get "/edit"=> "devise/passwords#new"
  end

  resource :users

  get "users/admin_page"
  get "users/users_page"
  get "users/index"
  get "users/view_users"
  get "users/user_page"
  get "users/manage_users"
  get "users/edit_record"
  post "users/save_record"
  get "users/user_stat"
  post "users/search"
  get "users/add_category"
  get "users/view_sub_cat"
  get "users/view"
  get "users/delete_category"
  get "users/update_category"
  post "users/update_record"
  get "users/change_pass"
  post "users/reset_pass"

  post "game/start_game"

  # post "users/user_page"
  get "game/set_category"
  get "game/set_word"
  get "game/new_game"
  get "users/found_users"
  get "users/search"
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
