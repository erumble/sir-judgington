Rails.application.routes.draw do
  resources :contestants

  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users
end