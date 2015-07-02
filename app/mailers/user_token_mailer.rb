class UserTokenMailer < ActionMailer::Base
  default from: "noreply@example.com" # NOTE: You'll want to change this

  def change_password(user_token)
    @user_token = user_token
    @user = user_token.user

    mail(
      to: @user.email,
      subject: 'Change your password'
    )
  end

  def signup(user_token)
    @user_token = user_token
    @user = user_token.user

    mail(
      to: @user.email,
      subject: '[sign up] confirm email'
    )
  end
end
