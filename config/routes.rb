Rails.application.routes.draw do

  devise_for :users
  resources :users

  resources :comments, only: :create
  resources :boosts, only: :create
  resources :goals

  root 'home#index'

  get '/goals/:id/delete', to: 'goals#confirm_delete', as: 'confirm_delete'

end
