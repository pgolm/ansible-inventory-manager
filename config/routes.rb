AnsibleWebInventory::Application.routes.draw do
  # Omniauth
  match 'auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  match 'auth/failure', to: redirect('/'), via: [:get, :post]

  match 'signin', to: 'sessions#new', as: 'signin', via: [:get, :post]
  match 'signout', to: 'sessions#destroy', as: 'signout', via: [:get, :post]

  # Auth
  resources :identities

  # Inventory
  resources :inventories do
    resources :hosts
    resources :groups
  end

  # Ansible API
  get '/ansible/inventory/:id', to: 'ansible_api#inventory'
  get '/ansible/inventory/:id/:host', to: 'ansible_api#host'

  # statics
  get '/help', to: 'static_pages#help'

  # Root
  root to: redirect('/inventories')
end
