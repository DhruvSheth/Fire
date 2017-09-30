Rails.application.routes.draw do
  get 'event/new'

  get 'event/create'

  get 'event/show'

  get 'event/index'

  devise_for :users
  resources :users, only: [:show]  


  root 'static_pages#home'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/home',    to: 'static_pages#home'
  get '/about',   to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
end
