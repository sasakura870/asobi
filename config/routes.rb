Rails.application.routes.draw do
  get 'tags/index'
  get 'home', to: 'static_pages#home'
  get 'about', to: 'static_pages#about'
  get 'help', to: 'static_pages#help'
  get 'terms', to: 'static_pages#terms'
  get 'privacy', to: 'static_pages#privacy'

  namespace :searches do
    resources :articles, only: :index
    resources :users, only: :index
    resources :tags, only: :index
  end

  resources :users, only: %i[show create destroy] do
    member do
      get :favorites
      get :followings
      get :followers
    end
  end
  get 'signup', to: 'users#new'

  namespace :settings do
    resources :profile, only: %i[index update]
    resources :account, only: %i[index update]
    resources :password, only: %i[index update]
    resources :remember, only: %i[create destroy]
    resources :quit, only: %i[index destroy]
    root 'profile#index'
  end

  resources :articles, except: :index do
    get :favorite, on: :member
  end

  resources :drafts, only: %i[index destroy]

  resources :tags, only: %i[show]

  resources :favorites, only: %i[create destroy]

  resources :comments, only: %i[create destroy]

  resources :relationships, only: %i[create destroy]

  resources :tag_maps, only: %i[create destroy]

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  resources :account_activations, only: %i[index edit]

  resources :resend_emails, only: :update

  root 'static_pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
