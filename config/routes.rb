Rails.application.routes.draw do
  namespace :admin do
    resources :categories
    resources :words
    root "static_pages#home"
  end
  root "static_pages#home"
  get "/help", to: "static_pages#help"
  get "/about", to: "static_pages#about"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :users
  resources :categories, only: [:index]
  resources :words, only: [:index, :show]
  resources :categories do
    resources :lessons
  end
end
