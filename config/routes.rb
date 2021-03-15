Rails.application.routes.draw do
  resources :leaderboards, only: [:index]
end
