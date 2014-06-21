PostitTemplate::Application.routes.draw do
  root to: 'posts#index'
  get '/posts/explore', to: 'posts#explore', as: :explore
  resources :posts, except: [:destroy] do
    resources :comments, only: [:create]
  end
  resources :categories, only: [:new, :create, :show]

  # User
  get '/register', to: 'users#new', as: :register
  post '/register', to: 'users#create'
  get '/profile', to: 'users#show', as: :profile
  get 'profile/edit', to: 'users#edit', as: :edit_profile
  patch 'profile/edit', to: 'users#update'
  post '/profile', to: 'users#update'

  # Sessions
  get '/login', to: 'sessions#new', as: :login
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy', as: :logout
end
