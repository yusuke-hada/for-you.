Rails.application.routes.draw do
  root to: 'pages#top'
  resources :users, only: %i[new create edit update]
end
