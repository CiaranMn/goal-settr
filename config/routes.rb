Rails.application.routes.draw do

  get 'category/index'
  get 'category/show'
  devise_for :users
  resources :goals

  root 'home#index'

  resources :users
  resources :category, only: [:show, :index]

  resources :comments, only: [:create]
  resources :boosts, only: [:create]


end
