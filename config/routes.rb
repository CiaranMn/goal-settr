Rails.application.routes.draw do

  devise_for :users
  resources :goals

  root 'home#index'

  resources :users



end
