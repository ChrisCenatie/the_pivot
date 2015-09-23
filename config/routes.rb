Rails.application.routes.draw do
  root "items#index"

  get "items", to: "items#index"
  get "items/:id", to: "items#show"

  get "cart", to: "cart_items#index"
  post "cart_items", to: "cart_items#create"
  delete "cart_items", to: "cart_items#destroy"

  resources :categories, only: [:index, :show]
end
