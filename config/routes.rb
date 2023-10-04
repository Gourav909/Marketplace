Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth', controllers: { sessions: 'sessions' }
  resources :properties
  resources :addresses
  resources :favourite_properties, param: :property_id
  resources :users do
    get :get_current_user, on: :collection
  end
  resources :cities, only: %i[index]
  # resources :users

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
