Rails.application.routes.draw do
  namespace :admin do
    root "static_pages#home"
    resources :subjects, only:[:new, :create]
  end
  root "static_pages#home"
  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :exams, except: [:edit, :destroy]
  resources :users
  namespace :admin do
    resources :users, only: [:index, :destroy, :show]
  end
end
