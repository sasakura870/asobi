module Utilities
  def browser_login(user)
    visit login_path
    fill_in 'session_email', with: user.email
    fill_in 'session_password', with: user.password
    click_on 'ログイン'
  end
end
