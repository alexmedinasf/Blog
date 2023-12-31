Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions',
                                    registrations: 'users/registrations',
                                    passwords: 'users/passwords' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ('/')
  root 'users#index'
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      post 'login', to: 'login#auth'
      resources :users, only: %i[index show] do
        resources :posts, only: [:index] do
          resources :comments, only: %i[index create]
        end
      end
    end
  end
  # Route to list all users
  # Route to show a specific user
  resources :users, only: %i[index show] do
    # Route to show all posts of a specific user
    # Route to show a specific post of a specific user
    resources :posts, only: %i[index new create show destroy] do
      resources :comments, only: %i[new create destroy]
      resources :likes, only: [:create]
    end
  end
end