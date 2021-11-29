Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :users
  root to: 'pages#home'
  resources :games
  resources :party_sessions do
    resources :guests
    resources :party_games do
      resources :votes, only: :create
    end
    resources :votes
  end
  resources :guests, only: :destroy
  resources :party_games, only: :destroy
end
