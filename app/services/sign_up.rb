module Services
  class SignUp
    def initialize(user_params)
      @user_params = user_params
    end

    def perform
      User.create(@user_params.to_hash)
    end
  end
end
