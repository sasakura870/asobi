require 'rails_helper'

RSpec.describe 'Header' do
  before { visit root_path }

  it 'ロゴが存在する' do
    within('header') { expect(page).to have_link('Asobi') }
  end
  it '検索フォームが存在する' do
    within('header') do
      expect(page).to have_field('q')
      expect(page).to have_button('検索')
    end
  end

  describe 'ログイン中' do
    let(:main_user) { create(:user) }
    before { browser_login(main_user) }

    it 'ドロップダウンメニュー用のボタンが存在する' do
      within('header') { expect(page).to have_link(main_user.name) }
    end

    describe 'ドロップダウンメニュー' do
      before do
        within('header') { click_on class: 'dropdown-toggle' }
      end

      it 'ドロップダウンメニューが存在する' do
        expect(page).to have_css('div', class: 'dropdown-menu', visible: true)
      end

      it 'マイページへのリンクが存在する' do
        within('.dropdown-menu') do
          expect(page).to have_css('a', text: 'マイページ')
          click_on 'マイページ'
          expect(page).to have_title(main_user.name)
        end
      end

      it 'ログアウトへのリンクが存在する' do
        within('.dropdown-menu') do
          expect(page).to have_css('a', text: 'ログアウト')
          click_on 'ログアウト'
          expect(page).to have_css('div', class: 'alert-success')
        end
      end
    end
  end

  describe 'ログイン前' do
    it '新規登録へのリンクが存在する' do
      expect(page).to have_css('a', text: '新規登録')
      click_on '新規登録'
      expect(page).to have_title('新規登録')
    end

    it 'ログイン画面へのリンクが存在する' do
      expect(page).to have_link('ログイン')
      click_on 'ログイン'
      expect(page).to have_title('ログイン')
    end
  end
end
