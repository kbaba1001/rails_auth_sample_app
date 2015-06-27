class Users::UsersController < Users::ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new
    @form = UserForm.new(User.new)
  end

  def create
    @form = sign_up(user_params)

    if @form.errors.empty?
      sign_in(@form)
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end

