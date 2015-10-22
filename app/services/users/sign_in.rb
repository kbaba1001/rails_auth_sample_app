module Users
  class SignIn
    def initialize(user, warden, scope = nil)
      @user = user
      @warden = warden
      @scope = scope
    end

    def perform
      @warden.set_user(@user, scope: @scope) if Users::StateMachine.new(@user).current_state.active?
    end
  end
end
