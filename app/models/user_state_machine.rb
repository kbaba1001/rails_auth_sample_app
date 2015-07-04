class UserStateMachine
  include Statesman::Machine

  state :pending, initial: true
  state :active

  transition from: :pending, to: :active
end
