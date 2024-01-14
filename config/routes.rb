Rails.application.routes.draw do
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  # ログイン前と後でrootを分ける
  constraints ->(request) { request.session[:user_id].present? } do
    root to: 'pages#after_login_top', as: :logged_in_root
  end
  root to: 'pages#top'
  get 'users/check_email', to: 'users#check_email'
  resources :users, only: %i[new create edit update] do
    collection do
      get 'step1'
      get 'step2'
      get 'step3'
      get 'autocomplete/business', to: 'autocomplete#business'
      get 'autocomplete/interest', to: 'autocomplete#interest'
      get 'autocomplete/relationship', to: 'autocomplete#relationship'
      get 'autocomplete/purpose', to: 'autocomplete#purpose'
    end
    resources :gift_suggestions, only: %i[index new create show destroy]
    resources :wish_lists, only: %i[index new create edit update destroy]
    resources :memos, only: %i[index new create edit update destroy]
    resources :message_cards, only: %i[index new create edit update destroy] do
      member do
        get 'image'
      end
    end
  end
end
