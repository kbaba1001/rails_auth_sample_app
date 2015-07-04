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

            user.update!(password_digest: Monban.hash_token(attributes[:password]))

            Users::StateMachine.new(user).write_initial_state!

            user_token = UserToken.create!(user: user)
            UserTokenMailer.signup(user_token).deliver
          end
        end
      end

      form
    end
  end
end
