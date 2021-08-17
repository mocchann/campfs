Rails.application.routes.draw do
  
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }
  # ゲストユーザーログイン
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

  root 'home#top'
  resources :fields, only: [:show, :search] do
    get 'search', on: :collection
  end
  resources :bookmarks, only: [:create, :destroy]
  resources :reviews
  resources :contacts, only: [:new, :create]
  get 'static_pages/terms'
  get 'static_pages/privacy_policy'

  namespace :users do
    get 'profile'
    patch 'profile_update'
  end
  resources :users, only: [:show]
end
