class UserForm < Reform::Form
  property :email, validates: {presence: true, uniqueness: true}
  property :password, validates: {presence: true, confirmation: {allow_blank: true}, length: {within: 6..20, allow_blank: true}}
  property :password_confirmation, validates: {presence: true}
end
