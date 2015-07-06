Monban.configure do |config|
  config.sign_up_service = Users::SignUp
  config.sign_in_service = Users::SignIn

  config.no_login_redirect = '/'
end
