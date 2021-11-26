Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :users
  root to: 'pages#home'
  resources :games
  resources :party_sessions do
    resources :guests
  end
  resources :guests, only: :destroy
end
