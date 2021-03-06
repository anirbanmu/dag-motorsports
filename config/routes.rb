Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#home'
  get '/help', to: 'static_pages#help'

  devise_for :users
  resources :games, only: [:show, :index]
  resources :circuits, only: [:show]
end
