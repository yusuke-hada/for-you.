Rails.application.routes.draw do
   get 'login', to: 'user_sessions#new'  
   post 'login', to: 'user_sessions#create'  
   delete 'logout', to: 'user_sessions#destroy'
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
