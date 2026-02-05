Rails.application.routes.draw do
  root "home#index"

  resources :users, only: [:new, :create]
  resource :session, only: [:new, :create, :destroy]
end
