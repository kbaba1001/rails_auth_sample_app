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
    resources :user_tokens, only: %i(new create)

    resources :users, only: %i(new create), shallow: true do
      resources :user_tokens, only: %i(edit update), param: :token
    end
  end

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: '/lo'
  end
end
