Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get "/users", to: "api/users#index"
  
  post "/users", to: "api/users#create"
  get "/me", to: "api/user#me"
  post "/auth/login", to: "api/auth#login"

  
end
