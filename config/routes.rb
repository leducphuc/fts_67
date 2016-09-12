Rails.application.routes.draw do
  root "static_pages#home"
  get "/about", to: "static_pages#about"
  get "/contact", to: "static_pages#contact"

  resources :users

  namespace :admin do
    resources :users, only: :index
  end
end
