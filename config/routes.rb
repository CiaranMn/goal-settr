Rails.application.routes.draw do

  devise_for :users
  resources :users

  resources :comments, only: :create
  resources :boosts, only: :create
  resources :goals

  root 'users#index'

  resources :category, only: [:show, :index]

  get '/goals/:id/delete', to: 'goals#confirm_delete', as: 'confirm_delete'

  get '/goals/:id/calendar', to: 'goals#calendar', as: 'calendar'

  patch '/goals/:id/calendar', to: 'goals#calendar_update', as: 'calendar_update'

end
