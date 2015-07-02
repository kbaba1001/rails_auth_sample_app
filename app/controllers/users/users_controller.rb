class Users::UsersController < Users::ApplicationController
  skip_before_action :require_login, only: [:new, :create, :edit, :update]

  def new
    @form = Users::SignUpForm.new(User.new)
  end

  def create
    @form = sign_up(params[:users_sign_up])

    render :new if @form.errors.present?
  end

  def edit
  end

  def update
    token = UserToken.find_by!(token: params[:token])

    # token を失効させる処理

    user = token.user
    # user のステータスを更新する処理

    sign_in user
    redirect_to root_path
  end
end

