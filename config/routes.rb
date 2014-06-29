Rails.application.routes.draw do
  resources :people

  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users
end