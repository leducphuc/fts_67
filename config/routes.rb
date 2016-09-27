Rails.application.routes.draw do
  root "static_pages#index"
  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :exams, except: [:edit, :destroy]
  resources :suggest_questions
  resources :users
  namespace :admin do
    root "static_pages#index", as: :home
    resources :users, only: [:index, :destroy, :show]
    resources :subjects
    resources :questions
    resources :suggest_questions, except: [:create, :edit]
  end
end
