require "monban/constraints/signed_in"
require "monban/constraints/signed_out"

Rails.application.routes.draw do
  constraints Monban::Constraints::SignedIn.new do
    root "users/dashboards#show", as: :dashboard
  end

  constraints Monban::Constraints::SignedOut.new do
    root "landings#show"
  end

  scope module: 'users' do
    resources :sessions, only: %i(new create destroy)
    resources :password_resets, only: %i(new create edit update), param: :token
    resource :password, only: %i(edit update)
    resources :users, shallow: true, only: %i(new create edit update), param: :token
  end

  namespace :admin do
    root 'sessions#new'

    resources :sessions, only: %i(new create destroy)

    resource :dashboard, only: %i(show)
  end

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: '/lo'
  end
end
