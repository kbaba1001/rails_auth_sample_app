class Users::ApplicationController < ApplicationController
  include Monban::ControllerHelpers

  def signed_in?
    user = warden.user
    user.class.name == 'User' ? user : nil
  end

  before_action :require_login
end
