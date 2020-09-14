Rails.application.routes.draw do
  root controller: :welcome, action: :index
  get '/auth/spotify/callback', to: 'sessions#create', as: 'login'
  get '/auth/failure', to: 'welcome#failure', as: 'login_fail'
  get '/dashboard', to: 'users#show', as: 'dashboard'
  get '/edit', to: 'users#edit'
  patch '/users', to: 'users#update' 
end
