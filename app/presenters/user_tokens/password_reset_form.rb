module UserTokens
  class PasswordResetForm < Reform::Form
    property :password, virtual: true, validates: {presence: true, confirmation: {allow_blank: true}, length: {within: 6..20, allow_blank: true}}
    property :password_confirmation, virtual: true, validates: {presence: true}
  end
end
