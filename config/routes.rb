Rails.application.routes.draw do

  root to: 'urls#index'
  get '/stats', to: 'urls#stats'
  post '/create', to: 'urls#create'
  get '/new', to: 'urls#new'
  get '/:short_url', to: 'urls#show'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
