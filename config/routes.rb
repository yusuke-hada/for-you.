Rails.application.routes.draw do
  get 'wish_lists/index'
  get 'wish_lists/new'
  get 'wish_lists/create'
  get 'wish_lists/edit'
  get 'wish_lists/update'
  get 'wish_lists/destroy'
  root to: 'pages#top'
  resources :users, only: %i[new create edit update] do
    collection do
      get 'step1'
      get 'step2'
      get 'step3'
    end
  end
end
