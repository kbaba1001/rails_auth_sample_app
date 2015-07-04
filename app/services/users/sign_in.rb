module Users
  class SignIn
    def initialize(user, warden)
      @user = user
      @warden = warden
    end

    def perform
      state_machine = UserStateMachine.new(@user)

      @warden.set_user(@user) if state_machine.current_state.active?
    end
  end
end
