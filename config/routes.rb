Rails.application.routes.draw do

  root to: 'urls#index'
  get '/urls/stats'
  post '/urls/create'
  get 'urls/new'
  get '/:short_url', to: "urls#show"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
