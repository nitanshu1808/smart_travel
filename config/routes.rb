Rails.application.routes.draw do
  devise_for :users, :controllers => {:registrations => "users/registrations", :omniauth_callbacks => "users/omniauth_callbacks", :sessions => "users/sessions"}

  unauthenticated :user do
    root 'travels#index'
  end
  authenticated :user do
    root "travels#dublin_bus"
  end

  resources :travels, only: :index

  get '/dublin_bus', to: 'travels#dublin_bus'
  get '/dublin_bikes', to: 'travels#dublin_bikes'

  # get '*path' => redirect('/')
end
