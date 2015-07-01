module Users
  class PasswordForm < Reform::Form
    property :current_password, virtual: true, validates: {presence: true}
    property :new_password, virtual: true, validates: {presence: true, confirmation: {allow_blank: true}, length: {within: 6..20, allow_blank: true}}
    property :new_password_confirmation, virtual: true, validates: {presence: true}

    validate do |form|
      unless Monban.config.authentication_service.new(form.model, form.current_password).perform
        errors.add(:current_password, :invalid)
      end
    end
  end
end
