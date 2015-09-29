Rails.application.routes.draw do
  root "static#index"

  get "vendors",      to: "static#show"

  get "cart",          to: "cart_items#index"
  post "cart_items",   to: "cart_items#create"
  patch "cart_items",  to: "cart_items#update"
  delete "cart_items", to: "cart_items#destroy"

  get "dashboard",    to: "users#show"

  get "login",        to: "sessions#new"
  post "login",       to: "sessions#create"
  delete "logout",    to: "sessions#destroy"

  resources :users, except: [:delete, :put]
  resources :orders, only: [:create, :show, :index, :update]
  resources :charges

  resources :categories, only: [:index, :show] do
    resources :items, only: [:show, :index]
  end

  namespace :admin do
    resources :items, except: [:show, :index]
    get "dashboard",    to: "users#show"
    post "dashboard",    to: "users#update"
  end

end
