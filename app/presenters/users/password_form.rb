module Users
  class PasswordForm < Reform::Form
    # TODO current_password と DB の値を比較する処理はどこに入れるのか？
    #      Monban の authenticate メソッドでできる
    property :current_password, virtual: true, validates: {presence: true}
    property :new_password, virtual: true, validates: {presence: true, confirmation: {allow_blank: true}, length: {within: 6..20, allow_blank: true}}
    property :new_password_confirmation, virtual: true, validates: {presence: true}
  end
end
