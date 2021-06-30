Rails.application.routes.draw do
  devise_for :users
  # root 'fields#index'
  root to: "home#index"
end
