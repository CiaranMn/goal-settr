Rails.application.routes.draw do

  devise_for :users
  resources :goals

  root 'home#index'

  resources :users

  resources :comments, only: [:create]
  resources :boosts, only: [:create]


end
