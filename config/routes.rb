Rails.application.routes.draw do
  devise_for :users

  root 'conversations#index'
  resources :conversations
  resources :messages

  resources :notifications, only: [] do
    member do
      post :set_seen
    end
  end
end
