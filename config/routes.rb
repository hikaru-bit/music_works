Rails.application.routes.draw do
  resources :videos
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'home#top'
  get "home/about"
  resources :posts, only: [:new, :create, :index, :show, :destroy, :edit, :update] do
    resource :favorites, only: [:create, :destroy]
  end
  get "users/confirm" => "users#confirm"
  patch "users/withdraw" => "users#withdraw"
  resources :users, only: [:show, :index, :edit, :update]
  post "users/:id" => "users#review"

end
