Rails.application.routes.draw do
  resources :leaderboards, only: [:index]
  resources :players, only: [:index, :show]
  resources :seasons, only: [:index, :show]
end
