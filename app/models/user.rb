class User < ActiveRecord::Base
  has_many :transitions, class_name: 'UserTransition', inverse_of: :user
  has_one :user_token
end
