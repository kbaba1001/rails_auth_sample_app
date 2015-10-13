feature "Signing in" do
  background do
    User.create(email: 'user@example.com', password_digest: Monban.hash_token('password'))
    Operator.create(email: 'admin1@example.com', password_digest: Monban.hash_token('password'))
  end

  scenario '' do
    expect(User.count).to eq(1)
    expect(Operator.count).to eq(1)
  end
end
