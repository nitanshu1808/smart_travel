Rails.application.routes.draw do
  get 'rooms/show'
  require 'sidekiq/web'

  mount Sidekiq::Web => "/sidekiq"


  devise_for :users, :controllers => {:registrations => "users/registrations", :omniauth_callbacks => "users/omniauth_callbacks", :sessions => "users/sessions"}

  unauthenticated :user do
    root 'travels#index'
  end
  authenticated :user do
    root "travels#dublin_bus"
  end

  resources :travels, only: :index

  get '/dublin_bus',        to: 'travels#dublin_bus'
  get '/dublin_bikes',      to: 'travels#dublin_bikes'
  get '/bus_stop',          to: 'travels#bus_stop'
  get '/bike_station',      to: 'travels#bike_station'
  get '/stop_info',         to: 'travels#stop_info'  
  get '/station_info',      to: 'travels#station_info'

  resources :pokemons
  post '/upload',            to: 'pokemons#upload'
  delete '/destroy_all',     to: 'pokemons#destroy_all', as: 'pokemons_destroy'
  
  # get '*path' => redirect('/')
  mount ActionCable.server => '/cable'
end
