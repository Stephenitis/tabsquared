Tabsquared::Application.routes.draw do

  root 'welcome#index'

  get '/auth/foursquare/callback', to: 'sessions#create'

  post '/listener', to: 'command#listener'

end
