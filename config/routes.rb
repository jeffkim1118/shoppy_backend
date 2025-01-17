Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  # Request for all registered users.
  get "/users", to: "api/users#index"
  
  # Request to create a new user in the database
  post "/users", to: "api/users#create"

  # Keeping me logged in
  get "/me", to: "api/user#me"

  # Logging in
  post "/login", to: "api/sessions#create"

  # post "/auth/login", to: "api/auth#login"

  
end
