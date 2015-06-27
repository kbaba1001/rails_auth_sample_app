module Services
  class SignUp
    def initialize(user_params)
      @user_params = user_params
    end

    def perform
      form = UserForm.new(User.new)

      if form.validate(@user_params)
        form.save do |attributes|
          user = form.model
          user.update(password_digest: Monban.hash_token(attributes[:password]))
        end
      end

      form
    end
  end
end
