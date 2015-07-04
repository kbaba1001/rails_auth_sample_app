class UserStateMachine
  include Statesman::Machine

  state :pending, initial: true
  state :active

  transition from: :pending, to: :active

  def initialize(user)
    super(user, transition_class: UserTransition, association_name: :transitions)
  end

  def current_state
    super.inquiry
  end
end
