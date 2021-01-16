Rails.application.routes.draw do
  devise_for :users
  root 'home#top'
  get 'about', to: 'home#about'
  resources :users, only: [:show, :edit, :update, :index]
  resources :books
end
