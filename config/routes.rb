Rails.application.routes.draw do
  resources :leaderboards, only: [:index]
  resources :seasons, only: [:index, :show]
end
