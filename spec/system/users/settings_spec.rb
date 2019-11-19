require 'rails_helper'

# TODO: 個別のページを作成する予定
RSpec.describe 'setting画面' do
  let(:main_user) { create(:user) }

  context 'ログインせずにsettingへ遷移する' do
    before { visit settings_path }
    it 'ログイン画面へリダイレクトされる' do
      expect(page).to have_title('ログイン')
    end
  end

  describe 'main_userとしてログイン' do
    before do
      browser_login(main_user)
      visit settings_path
    end

    it '各入力フォームに、main_userの値が入力されている' do
      expect(page).to have_css('input', id: 'user_name')
    end
  end
end
