Rails.application.routes.draw do
  root "items#index"

  resources :items, only: [:index, :show, :new, :create]

  get "cart",          to: "cart_items#index"
  post "cart_items",   to: "cart_items#create"
  patch "cart_items",  to: "cart_items#update"
  delete "cart_items", to: "cart_items#destroy"

  get "dashboard",    to: "users#show"

  resources :categories, only: [:index, :show]
  resources :users, only: [:new, :create, :show]

  get "login",        to: "sessions#new"
  post "login",       to: "sessions#create"
  delete "logout",    to: "sessions#destroy"

  resources :orders, only: [:create, :show, :index]

  namespace :admin do
    get "dashboard",    to: "users#show"
  end
end
