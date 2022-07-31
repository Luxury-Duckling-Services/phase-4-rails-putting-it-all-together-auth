Rails.application.routes.draw do
  resources :recipes, only: [:index , :create]
  
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  post "/signup", to: "users#create"
  get "/me", to: "users#show"

end
