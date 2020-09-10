Rails.application.routes.draw do
  get '/', to: 'welcome#index'
  get '/auth/spotify/callback', to: 'sessions#create'
  get '/auth/failure', to: 'welcome#failure'
  get '/dashboard', to: 'users#show'
end
