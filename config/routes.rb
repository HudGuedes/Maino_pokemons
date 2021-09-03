Rails.application.routes.draw do
  devise_for :users
  root to:'teams#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :pokemons, only: [:new, :create, :destroy]
  resources :teams
end
