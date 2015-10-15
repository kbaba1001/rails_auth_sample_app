Monban.configure(:user) do |config|
  config.sign_up_service = Users::SignUp
  config.sign_in_service = Users::SignIn

  config.no_login_redirect = '/'
end

Monban.configure(:operator) do |config|
  config.user_class = 'Operator'

  config.sign_up_service = Monban::Services::SignUp
  config.sign_in_service = Monban::Services::SignIn

  config.no_login_redirect = admin_root_path
end
