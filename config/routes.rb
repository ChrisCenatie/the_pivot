Rails.application.routes.draw do
  root "static#index"

  resources :farmers, only: [:index]
  resources :addresses, only: [:create, :new, :create, :update]

  get "cart",          to: "cart_items#index"
  post "cart_items",   to: "cart_items#create"
  patch "cart_items",  to: "cart_items#update"
  delete "cart_items", to: "cart_items#destroy"

  get "dashboard",    to: "users#show"

  get "login",        to: "sessions#new"
  post "login",       to: "sessions#create"
  delete "logout",    to: "sessions#destroy"

  post "notifications/notify", to: "notifications#notify"

  resources :users, except: [:delete, :put]
  resources :orders, only: [:create, :show, :index, :update]
  resources :charges

  resources :categories, only: [:index, :show] do
    resources :items, only: [:show, :index]
  end

  namespace :admin do
    resources :items, except: [:show, :index]
    resources :farmers, only: [:index, :update]
    get "dashboard",    to: "users#show"
    post "dashboard",    to: "users#update"
  end

  namespace :farmer_admin do
    resources :items
    resources :farmers, only: [:edit, :update]
    resources :users, only: [:new, :create, :update]
    get "dashboard",    to: "users#show"
    resources :orders, only: [:update]
  end

  namespace :farmers, path: ":farmer", as: :farmer do
    resources :items, only: [:index, :show]
  end
end
