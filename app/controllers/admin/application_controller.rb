class Admin::ApplicationController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include Monban::ControllerHelpers
  helper_method :current_operator

  # SignIn で scope

  undef :current_user
  def current_operator
    @current_operator ||= warden.user(:operator)
  end

  def signed_in?
    warden.user(:operator)
  end

  def require_login
    unless signed_in?
      redirect_to admin_root_path
    end
  end

  before_action :require_login
end
