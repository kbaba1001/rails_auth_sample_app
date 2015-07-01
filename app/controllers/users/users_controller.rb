class Users::UsersController < Users::ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new
    @form = Users::SignUpForm.new(User.new)
  end

  def create
    @form = sign_up(params[:users_sign_up])

    if @form.errors.empty?
      # token付きのemailを送る
      # メール中の url の宛先は /first_login/xxxxxxxx ?

      sign_in(@form)
      redirect_to root_path
    else
      render :new
    end
  end
end

