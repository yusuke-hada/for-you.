Rails.application.routes.draw do
  root to:'pages#top'
  resources :users, only: [:new, :create, :edit ,:update]
end
