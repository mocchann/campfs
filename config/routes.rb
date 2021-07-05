Rails.application.routes.draw do
  
  root 'home#top'
  devise_for :users
  resources :fields do
    get "search", on: :collection
  end
  namespace :users do
    get 'profile'
    patch 'profile_update'
  end
end
