Rails.application.routes.draw do
  post 'oauth/callback', to: 'oauths#callback'
  get 'oauth/callback', to: 'oauths#callback'
  get 'oauth/:provider', to: 'oauths#oauth', as: :auth_at_provider
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  post 'guest_login', to: 'user_sessions#guest_login'
  delete 'logout', to: 'user_sessions#destroy'
  constraints ->(request) { request.session[:user_id].present? } do
    root to: 'pages#after_login_top', as: :logged_in_root
  end
  root to: 'pages#top'
  get 'pages/privacy_policy', to: 'pages#privacy_policy'
  get 'pages/terms_of_use', to: 'pages#terms_of_use'
  get 'users/check_email', to: 'users#check_email'
  resource :profile, only: %i[show edit update]
  resources :password_resets, only: %i[new create edit update]
  resources :users, only: %i[new create] do
    collection do
      get 'step1'
      get 'step2'
      get 'step3'
      get 'autocomplete/business', to: 'autocomplete#business'
      get 'autocomplete/interest', to: 'autocomplete#interest'
      get 'autocomplete/relationship', to: 'autocomplete#relationship'
      get 'autocomplete/purpose', to: 'autocomplete#purpose'
    end
  end
  resources :gift_suggestions, only: %i[index new create show destroy]
  resources :wish_lists, only: %i[index new create edit update destroy]
  resources :memos, only: %i[index new create edit update destroy]
  resources :anniversaries
  resources :message_cards, only: %i[index new create edit update destroy] do
    member do
      get 'image'
    end
  end
end
