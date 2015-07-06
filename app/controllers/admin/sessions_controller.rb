class Admin::SessionsController < Admin::ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new
  end

  def create
    operator = authenticate_session(session_params)

    if sign_in(operator)
      redirect_to admin_dashboard_path
    else
      render :new
    end
  end

  def destroy
    sign_out
    redirect_to admin_root_path
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end

