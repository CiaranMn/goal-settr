Rails.application.routes.draw do
  devise_for :users
  resources :goals
  resources :users

  root 'home#index'



end
