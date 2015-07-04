class Users::UsersController < Users::ApplicationController
  skip_before_action :require_login, only: %i(new create edit update)

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
    user = token.user

    ActiveRecord::Base.transaction do
      Users::StateMachine.new(user).transition_to!(:active)
      token.destroy!
    end

    sign_in user
    redirect_to root_path
  rescue
    redirect_to root_path, alert: 'ERROR'
  end
end
