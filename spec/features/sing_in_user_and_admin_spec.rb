feature "Signing in" do
  let!(:user) {
    User.create(
      email: 'user@example.com',
      password_digest: Monban.hash_token('password')
    ).tap {|user|
      Users::StateMachine.new(user).transition_to!(:active)
    }
  }
  let!(:operator) { Operator.create(email: 'admin1@example.com', password_digest: Monban.hash_token('password')) }

  scenario 'ユーザーでサインイン中に管理者でサインインした場合、管理者の情報を取得できること' do
    # ユーザーでサインイン
    visit '/sessions/new'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password'
    click_button 'Sign in'

    expect(page).to have_content 'ログイン後マイページ'
    expect(page).to have_content 'current_user: User'

    # 管理者でサインイン
    visit '/admin'
    fill_in 'Email', with: operator.email
    fill_in 'Password', with: 'password'
    click_button 'sign in'

    expect(page).to have_content '管理画面のダッシュボード'
    expect(page).to have_content 'current_user: Operator'
  end
end
