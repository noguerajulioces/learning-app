Rails.application.routes.draw do
  root 'home#index'
  devise_for :users
  resources :courses
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'static_pages/landing_page'
  get 'static_pages/privacy_policy'
end
