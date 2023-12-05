Rails.application.routes.draw do
  root to: 'pages#top'
  resources :users, only: %i[new create edit update] do
    collection do
      get 'step1'
      get 'step2'
      get 'step3'
    end
    resources :wish_lists
  end
end
