Rails.application.routes.draw do
  scope module: 'users' do
    root to: 'dashboards#show'

    resource :session, only: %i(new create destroy)
    resources :password_resets, only: %i(new create)

    resources :users, only: %i(new create) do
      resources :password_resets, only: %i(edit update)
    end
  end

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: '/lo'
  end
end
