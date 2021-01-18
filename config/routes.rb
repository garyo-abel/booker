Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  root 'home#top'
  get 'home/about', to: 'home#about', as: 'about'
  resources :users, only: [:show, :edit, :update, :index]
  resources :books
end
