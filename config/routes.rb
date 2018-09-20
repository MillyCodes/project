Rails.application.routes.draw do
  get '/artists', to: 'artists#index'
  get '/artists/:id', to:'artists#show', as: 'artist'
  root 'home#index'
end
