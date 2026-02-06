Rails.application.routes.draw do
  get "/favicon.ico", to: redirect("/icon.png")

  get "books/index"
  get "books/new"
  get "books/create"
  get "books/search", to: "books#search"
  root "books#index"

  resources :users, only: [:new, :create]
  resource :session, only: [:new, :create, :destroy]
  resources :books, only: [:index, :new, :create, :show, :edit, :update, :destroy]
  

end
