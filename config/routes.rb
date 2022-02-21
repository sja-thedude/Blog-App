Rails.application.routes.draw do
  root to: 'users#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :users, only: %i[index show] do
    resources :posts, only: %i[index create new show]
  end
  # Defines the root path route ("/")
  # root "articles#index"
  resources :posts do
    resources :comments, only: [:create]
    resources :likes, only: [:create]
  end
end
