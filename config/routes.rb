Rails.application.routes.draw do
  root "listings#index"
  resources :listings do
    member do
      patch :like, to: 'listings#like_listing'
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
end
