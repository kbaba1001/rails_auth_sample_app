module Services
  class SignUp
    def initialize(users_sign_up_params)
      @users_sign_up_params = users_sign_up_params
    end

    def perform
      form = Users::SignUpForm.new(User.new)

      if form.validate(@users_sign_up_params)
        form.save do |attributes|
          user = form.model
          user.update(password_digest: Monban.hash_token(attributes[:password]))
        end
      end

      form
    end
  end
end
