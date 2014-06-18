PostitTemplate::Application.routes.draw do
  root to: 'posts#index'
  get 'posts/explore', to: 'posts#explore', as: :explore
  resources :posts, except: [:destroy] do
    resources :comments, only: [:create]
  end
  resources :categories, only: [:new, :create, :show]
end
