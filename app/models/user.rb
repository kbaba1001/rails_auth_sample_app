class User < ActiveRecord::Base
  has_many :user_transitions, inverse_of: :user
  has_one :user_token

  include Statesman::Adapters::ActiveRecordQueries

  private

  def self.transition_class
    UserTransition
  end

  def self.initial_state
    :pending
  end
end
