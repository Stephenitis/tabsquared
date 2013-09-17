Tabsquared::Application.routes.draw do

  root 'welcome#index'

  resources :users, only: [:show, :edit, :update]
  resources :sessions, only: [:create]

  match '/signout', to: 'sessions#destroy', via: :delete

  get '/auth/foursquare/callback', to: 'sessions#create'

  post '/listener', to: 'command#listener'

  post '/test', to: 'command#test'

  post '/verify', to: 'users#verify'

  get '/about', to: 'welcome#about'

end
