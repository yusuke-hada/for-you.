Rails.application.routes.draw do
  get 'user_sessions/new'
  get 'user_sessions/create'
  get 'user_sessions/destroy'
  root to: 'pages#top'
  get 'users/check_email', to: 'users#check_email'
  resources :users, only: %i[new create edit update] do
    collection do
      get 'step1'
      get 'step2'
      get 'step3'
    end
    resources :wish_lists
  end
end
