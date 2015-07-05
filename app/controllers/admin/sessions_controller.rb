class Admin::SessionsController < Admin::ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new
  end

  def create
    # NOTE Userモデルを使えないので authenticate_session は使わず、直接 Operator を find する
    operator = authenticate(Operator.find_by(email: session_params[:email]), session_params[:password])

    # NOTE monban の warden メソッドを直接使うのがちょっと汚い感じ...
    if warden.set_user(operator, scope: :operator)
      redirect_to admin_dashboard_path
    else
      render :new
    end
  end

  def destroy
    sign_out
    redirect_to new_admin_session_path
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end

