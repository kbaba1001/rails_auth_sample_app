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

  end
end

