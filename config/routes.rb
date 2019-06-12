# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :occurrences, only: [:index]
  resources :users, only: [:new, :create, :destroy] do
    get :unsubscribe
  end



  root to: 'occurrences#index'

  require 'sidekiq/web'
  require 'sidekiq/cron/web'

  Sidekiq::Web.set :session_secret, Rails.application.credentials[:secret_key_base]

  mount Sidekiq::Web => '/sidekiq'
end
