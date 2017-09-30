Rails.application.routes.draw do
  devise_for :users
  resources :users,             only: [:show]  
  resources :events,            only: [:new, :create, :show, :index]
  resources :event_attendances, only: [:new, :create]
  resources :interests,         only: [:new, :create, :destroy]
  resources :groups,            only: [:new, :create, :destroy, :show]

  root 'static_pages#home'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/home',    to: 'static_pages#home'
  get '/about',   to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
end

