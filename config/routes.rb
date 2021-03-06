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
    resource :session, only: %i(new create destroy)
    resources :password_resets, only: %i(new create edit update), param: :token
    resource :password, only: %i(edit update)
    resources :users, shallow: true, only: %i(new create edit update), param: :token
  end

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: '/lo'
  end
end
