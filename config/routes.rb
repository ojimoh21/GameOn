Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :users
  root to: 'pages#home'
  resources :games
  resources :party_sessions do
    resources :guests
    resources :chatrooms, only: :show do
      resources :messages, only: :create
    end
  end
  resources :guests, only: :destroy
  resources :chatrooms, only: :show do
    resources :messages, only: :create
  end
end
