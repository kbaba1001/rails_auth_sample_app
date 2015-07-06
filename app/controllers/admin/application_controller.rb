class Admin::ApplicationController < ApplicationController
  include Monban::ControllerHelpers

  prepend_before_action {
    Monban.configure do |config|
      config.user_class = 'Operator'

      config.sign_up_service = Monban::Services::SignUp
      config.sign_in_service = Monban::Services::SignIn

      config.no_login_redirect = admin_root_path
    end
  }

  def signed_in?
    operator = warden.user
    operator.class.name == 'Operator' ? operator : nil
  end


  # helper_method :current_operator

  # undef :current_user
  # def current_operator
  #   # FIXME なぜか User が入ってしまうようだ...。なんで?
  #   @current_operator = warden.user(scope: :operator)
  # end

  # def signed_in?
  #   warden.user(scope: :operator)
  # end

  # def require_login
  #   unless signed_in?
  #     redirect_to admin_root_path
  #   end
  # end

  before_action :require_login
end
