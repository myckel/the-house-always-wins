Rails.application.routes.draw do
  devise_for :users

  # Set the root path to the login form
  devise_scope :user do
    root to: 'devise/sessions#new'
  end

  resources :users do
    resource :game_session, only: [:show] do
      member do
        post :roll
        post :cash_out
      end
    end
  end
end
