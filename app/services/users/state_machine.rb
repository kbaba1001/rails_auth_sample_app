module Users
  class StateMachine
    include Statesman::Machine

    state :pending, initial: true
    state :active

    transition from: :pending, to: :active

    def initialize(user)
      super(user, transition_class: UserTransition)
    end

    def current_state
      super.inquiry
    end

    def write_initial_state!
      object.user_transitions.create!(
        to_state: self.class.initial_state,
        sort_key: 0,
        most_recent: true
      )
    end
  end
end
