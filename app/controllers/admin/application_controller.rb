class Admin::ApplicationController < ApplicationController
  include Monban::ControllerHelpers

  # prepend_before_action {
  #   Monban.configure do |config|
  #     config.user_class = 'Operator'

  #     config.sign_up_service = Monban::Services::SignUp
  #     config.sign_in_service = Monban::Services::SignIn

  #     config.no_login_redirect = admin_root_path
  #   end
  # }

  # def signed_in?
  #   operator = warden.user
  #   operator.class.name == 'Operator' ? operator : nil
  # end

  before_action :require_login

  private

  def authenticate_scope
    :operator
  end
end
