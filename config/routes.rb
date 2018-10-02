Rails.application.routes.draw do

  devise_for :users do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  
  resources :goals
  resources :users, only: [:index, :show]

  root 'home#index'




end
