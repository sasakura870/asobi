require 'rails_helper'

RSpec.describe 'Header' do
  before { visit root_path }

  it 'ロゴが存在する' do
    within('header') { expect(page).to have_link 'Asobi' }
  end
  it '検索フォームが存在する' do
    within('header') { expect(page).to have_field('q') }
  end

  describe 'ログイン中' do
    let(:main_user) { create(:user) }
    before { browser_login(main_user) }

    it 'ドロップダウンメニュー用のボタンが存在する' do
      within('header') { expect(page).to have_link main_user.name }
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
          expect(page).to have_link 'マイページ'
          click_on 'マイページ'
        end
        expect(page).to have_title(main_user.name)
      end

      it 'プロフィールの設定へのリンクが存在する' do
        within('.dropdown-menu') do
          expect(page).to have_link '設定'
          click_on '設定'
        end
        expect(page).to have_content 'ユーザー設定'
      end

      it '下書き一覧へのリンクが存在する' do
        within('.dropdown-menu') do
          expect(page).to have_link '下書き一覧'
          click_on '下書き一覧'
        end
        expect(page).to have_title '下書き一覧'
      end

      it 'ログアウトへのリンクが存在する' do
        within('.dropdown-menu') do
          expect(page).to have_link 'ログアウト'
          click_on 'ログアウト'
        end
        expect(page).to have_css('div', class: 'alert-success')
      end
    end
  end

  describe 'ログアウト中' do
    it '新規登録へのリンクが存在する' do
      expect(page).to have_link '新規登録'
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
