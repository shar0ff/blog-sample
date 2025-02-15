Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # get "up" => "rails/health#show", as: :rails_health_check

  get "home", to: "static_pages#home"
  get "reviews", to: "static_pages#reviews"
  get "categories", to: "static_pages#categories"
  get "contact", to: "static_pages#contact"

  devise_for :users

  # Creates all CRUD routes for blog_posts entity
  resources :blog_posts do
    resource :cover_image, only: [:destroy], module: :blog_posts
    resources :comments, only: [:create, :destroy]
  end

  # Defines the root path route ("/")
  root "static_pages#home"
end
