Rails.application.routes.draw do
  
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  root 'home#top'
  resources :fields, only: [:show, :search] do
    get 'search', on: :collection
  end
  resources :bookmarks, only: [:create, :destroy]
  resources :reviews
  
  # ゲストユーザーログイン
  post '/home/guest_sign_in', to: 'home#guest_sign_in'

  namespace :users do
    get 'profile'
    patch 'profile_update'
  end
  resources :users, only: [:show]
end
