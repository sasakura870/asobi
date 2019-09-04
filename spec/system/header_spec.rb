require 'rails_helper'

RSpec.describe 'Header' do
  before { visit root_path }

  describe 'ログインしている場合' do
    let(:main_user) { FactoryBot.create(:user) }
    before { browser_login(main_user) }

    it '自分のプロフィールへのリンクが存在する' do
      within 'header' do
        expect(page).to have_css('a', text: main_user.name)
      end
    end

    it 'ログアウトが存在する(仮)' do
      within 'header' do
        expect(page).to have_css('a', text: 'ログアウト')
      end
    end

    context 'ログアウトを押す' do
      before { click_on 'ログアウト' }
      it 'ログアウトする' do
        expect(page).to have_css('div', class: 'alert-success', text: 'ログアウトしました')
      end
    end
  end

  describe 'ログインしていない場合' do
    it '新規登録とログインが存在する' do
      within 'header' do
        expect(page).to have_css('a', text: '新規登録')
        expect(page).to have_css('a', text: 'ログイン')
      end
    end

    context '新規登録を押す' do
      before { click_on '新規登録' }
      it '新規登録画面へ遷移する' do
        expect(page).to have_title('新規登録')
      end
    end

    context 'ログインを押す' do
      before { click_on 'ログイン' }
      it 'ログイン画面へ遷移する' do
        expect(page).to have_title('ログイン')
      end
    end
  end
end
