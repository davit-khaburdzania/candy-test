Rails.application.routes.draw do
  devise_for :users

  root 'conversations#index'
  resources :conversations
  resources :messages
end
