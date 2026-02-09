Rails.application.routes.draw do
  get "/favicon.ico", to: redirect("/icon.png")

  root "books#index"

  resources :books do
    collection do
      get :search
    end
  end

  resources :users, only: [:new, :create]
  resource  :session, only: [:new, :create, :destroy]
end
