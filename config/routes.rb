Rails.application.routes.draw do

  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users

  resources :entries

  resources :contests

  unless Rails.application.config.consider_all_requests_local
    match '*not_found', to: 'errors#error_404', via: [:get, :post]
  end

end
