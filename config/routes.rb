Tabsquared::Application.routes.draw do

  root 'welcome#index'

  resources :users, only: [:show, :edit, :update]
  resources :sessions, only: [:create, :destroy]

  get '/auth/foursquare/callback', to: 'sessions#create'

  post '/listener', to: 'command#listener'

end
