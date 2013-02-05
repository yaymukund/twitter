Twitter::Application.routes.draw do
  root to: 'home#index'

  resource :user, only: [:new, :create, :edit, :update]
  resource :session, only: [:new, :create, :destroy]
  resources :tweets, only: [:index, :new, :create, :show, :destroy]
  resources :users, only: :show, as: :timeline
end
