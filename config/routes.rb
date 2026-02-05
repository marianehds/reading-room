Rails.application.routes.draw do
  get "books/index"
  get "books/new"
  get "books/create"
  root "home#index"

  resources :users, only: [:new, :create]
  resource :session, only: [:new, :create, :destroy]
  resources :books, only: [:index, :new, :create]

end
