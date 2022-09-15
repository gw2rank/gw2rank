Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" },
    skip: [:sessions, :registrations]

  devise_scope :user do
    get "/users", to: "devise/sessions#new", as: :new_user_session
    post "/users/sign_in", to: "devise/sessions#create", as: :user_session
    get "/users/sign_out", to: "devise/sessions#destroy", as: :destroy_user_session
  end

  authenticated :user do
    resources :players, only: [:new, :create]
  end

  resources :leaderboards, only: [:index]
  resources :players, only: [:index, :show]
  resources :seasons, only: [:index, :show]
end
