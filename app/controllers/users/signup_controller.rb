class Users::SignupController < Users::ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new
    @form = Users::SignUpForm.new(User.new)
  end

  def create
    # これじゃダメっす〜
    # 入力された email や password を DB に保存しないとダメだけど、
    # token が確認されるまで無効にするようにする処理が必要。
    # そう考えると URL は User#new や User#create でもいいのかなー
    @form = Users::SignUpForm.new(User.new)

    if @form.validate(params[:users_sign_up])
      user_token = UserToken.create(user: @form.model)
      UserTokenMailer.signup(user_token).deliver
    else
      render :new
    end
  end

  def edit

  end

  def update

  end
end
