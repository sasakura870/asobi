require 'rails_helper'

RSpec.describe 'Header' do
  before { visit root_path }

  it 'ロゴが存在する' do
    within 'header' do
      expect(page).to have_css('a', text: 'Asobi')
    end
  end

  context 'トグルをクリックした場合' do
    before do
      page.driver.browser.manage.window.resize_to(700, 500)
      click_button class: 'navbar-toggler'
    end
    it '検索ボタンが存在する(仮)' do
      within 'header' do
        expect(page).to have_css('a', text: '検索')
      end
    end
  end

  xdescribe 'ログインしている場合' do
    let(:main_user) { create(:user) }
    before { browser_login(main_user) }

    it '自分のプロフィールへのリンクが存在する' do
      within 'header' do
        expect(page).to have_css('a#dropdown_profile')
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

  xdescribe 'ログインしていない場合' do
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
