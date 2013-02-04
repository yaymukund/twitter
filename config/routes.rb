Twitter::Application.routes.draw do
  root to: 'home#index'

  resources :user, only: [:new, :create, :edit, :update] do
    collection do
      get :settings
    end
  end

  resource :session, only: [:new, :create, :destroy]
  resources :tweets, only: [:index, :new, :create, :show, :destroy]
end
