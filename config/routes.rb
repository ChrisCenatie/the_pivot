Rails.application.routes.draw do
  root "items#index"
  get "/items", to: "items#index"
  get "/items/:id", to: "items#show"
  resources :categories, only: [:index, :show]
end
