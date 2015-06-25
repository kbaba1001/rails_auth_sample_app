class Users::PasswordResetsController < Users::ApplicationController
  skip_before_action :require_login, only: [:new, :create, :edit, :update]

  def new
    @user_token = UserToken.new
  end

  def create
    user = User.find_by(email: params[:user_token][:email])
    if user
      user_token = UserToken.create(user: user)
      UserTokenMailer.change_password(user_token).deliver
    end
  end

  def edit
    @user_token = UserToken.find_by!(token: params[:token])
  end

  def update
    @user_token = UserToken.find_by!(token: params[:token])
    user = @user_token.user

    reset_password(user, params[:user_token][:password])

    if user.save
      sign_in user
      redirect_to root_path
    else
      render :edit
    end
  end
end
