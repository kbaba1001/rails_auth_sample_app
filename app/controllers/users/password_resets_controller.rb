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
    @form = UserTokens::PasswordResetForm.new(UserToken.find_by!(token: params[:token]))
  end

  def update
    @form = UserTokens::PasswordResetForm.new(UserToken.find_by!(token: params[:token]))

    if @form.validate(params[:user_tokens_password_reset])
      user = @form.model.user

      @form.save do |attributes|
        user.update(password_digest: Monban.hash_token(params[:user_tokens_password_reset][:password]))
      end

      sign_in user
      redirect_to root_path
    else
      render :edit
    end
  end
end
