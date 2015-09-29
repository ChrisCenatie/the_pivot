Rails.application.routes.draw do
  root "static#index"
  
  get "vendors",      to: "static#show"

  resources :categories, only: [:index, :show] do
    resources :items, only: [:show, :index]
  end
  resources :items, except: [:show, :index]

  get "cart",          to: "cart_items#index"
  post "cart_items",   to: "cart_items#create"
  patch "cart_items",  to: "cart_items#update"
  delete "cart_items", to: "cart_items#destroy"

  get "dashboard",    to: "users#show"

  resources :users, only: [:new, :create, :show, :edit, :update, :patch]

  get "login",        to: "sessions#new"
  post "login",       to: "sessions#create"
  delete "logout",    to: "sessions#destroy"

  resources :orders, only: [:create, :show, :index, :update]

  namespace :admin do
    get "dashboard",    to: "users#show"
    post "dashboard",    to: "users#update"
  end
end
