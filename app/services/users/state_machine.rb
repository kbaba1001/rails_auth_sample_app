module Users
  class StateMachine
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

    def write_initial_state!
      object.transitions.create!(
        to_state: self.class.initial_state,
        sort_key: 0,
        most_recent: true
      )
    end
  end
end
