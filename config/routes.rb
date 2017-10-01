Rails.application.routes.draw do
  resources :storages
  devise_for :users
  resources :trucks
  resources :histories
  resources :parts
  root "parts#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
