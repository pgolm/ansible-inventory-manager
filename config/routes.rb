AnsibleWebInventory::Application.routes.draw do
  # Omniauth
  match 'auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  match 'auth/failure', to: redirect('/'), via: [:get, :post]
  match 'signout', to: 'sessions#destroy', as: 'signout', via: [:get, :post]

  # Auth
  resources :sessions
  resources :identities

  # Inventory
  resources :inventories do
    resources :hosts
    resources :groups
  end

  # statics
  get '/help', to: 'static_pages#help'

  # Root
  root to: redirect('/inventories')
end
