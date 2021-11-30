Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :users
  root to: 'pages#home'
  patch "confirm_availability/:party_session_id", to: "guests#toggle_availability", as: :confirm_availability
  patch "unconfirm_availability/:party_session_id", to: "guests#toggle_availability", as: :unconfirm_availability
  patch "confirm_arrival/:party_session_id", to: "guests#toggle_arrival", as: :confirm_arrival
  patch "unconfirm_arrival/:party_session_id", to: "guests#toggle_arrival", as: :unconfirm_arrival
  resources :games
  resources :party_sessions do
    resources :guests
    resources :teams
    resources :party_games do
      resources :votes, only: :create
      resources :teams, only: [:index, :create]
    end
    resources :votes
  end
  resources :guests, only: :destroy
  resources :party_games, only: :destroy
end
