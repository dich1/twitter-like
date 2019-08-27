Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'tweets#index'
  resources :users, only: [:index, :show, :new, :create]
  resources :tweets, only: [:create, :destroy]
end
