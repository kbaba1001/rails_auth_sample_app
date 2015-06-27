class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true

  attr_accessor :password, :password_confirmation
  validates_presence_of :password, :password_confirmation
  validates_length_of :password, within: 6..20, allow_blank: true
  validates_confirmation_of :password, allow_blank: true
end
