Rails.application.routes.draw do
  get '/artists', to: 'artists#index'
  get '/artists/:id', to:'artists#show', as: 'artist'
  get '/artists/new', to:'artists#new'
  root 'home#index'
end
