Rails.application.routes.draw do

  resources :users, only: [:new, :create]
  resource :session, only: [:new, :create, :destroy]

  resources :subs, only: [:new, :create, :index, :update, :edit, :show]
  resources :posts, only: [:new, :create, :update, :edit, :show, :destroy] do
    resources :comments, only: [:new]
  end

  resources :comments, only: [:create]
end
