module Users
  class SignUp
    def initialize(users_sign_up_params)
      @users_sign_up_params = users_sign_up_params
    end

    def perform
      form = Users::SignUpForm.new(User.new)

      if form.validate(@users_sign_up_params)
        ActiveRecord::Base.transaction do
          form.save do |attributes|
            user = form.model
            # TODO emailアドレスの確認ができるまではこのアカウントで sing in できなくする。
            # roll というか status カラムを作って、pandit とかで認可したい
            user.update!(password_digest: Monban.hash_token(attributes[:password]))
            # TODO 初期状態の投入

            user_token = UserToken.create!(user: user)
            UserTokenMailer.signup(user_token).deliver
          end
        end
      end

      form
    end
  end
end
