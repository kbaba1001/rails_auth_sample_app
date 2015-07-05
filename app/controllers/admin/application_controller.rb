class Admin::ApplicationController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include Monban::ControllerHelpers
  helper_method :current_operator

  undef :current_user
  def current_operator
    # FIXME なぜか User が入ってしまうようだ...。なんで?
    @current_operator = warden.user(scope: :operator)
  end

  def signed_in?
    warden.user(scope: :operator)
  end

  def require_login
    unless signed_in?
      redirect_to admin_root_path
    end
  end

  before_action :require_login
end
