module Services
  class SignUp
    def initialize(users_sign_up_params)
      @users_sign_up_params = users_sign_up_params
    end

    def perform
      form = Users::SignUpForm.new(User.new)

      if form.validate(@users_sign_up_params)
        # TODO fome.save は Transaction をはるかどうか調べる
        form.save do |attributes|
          user = form.model
          # TODO emailアドレスの確認ができるまではこのアカウントで sing in できなくする。
          # roll というか status カラムを作って、pandit とかで認可したい
          user.update(password_digest: Monban.hash_token(attributes[:password]))

          user_token = UserToken.create(user: user)
          UserTokenMailer.signup(user_token).deliver
        end
      end

      form
    end
  end
end
