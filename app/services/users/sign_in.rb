module Users
  class SignIn
    def initialize(user, warden)
      @user = user
      @warden = warden
    end

    def perform
      @warden.set_user(@user) if Users::StateMachine.new(@user).current_state.active?
    end
  end
end
