require 'rails_helper'

RSpec.describe 'Header' do
  before { visit root_path }

  it 'ロゴが存在する' do
    within('header') { expect(page).to have_css('a', text: 'Asobi') }
  end
  it '検索ボタンが存在する(仮)' do
    within('header') { expect(page).to have_css('a', text: '検索') }
  end
  it 'ユーザー検索ボタンが存在する(仮)' do
    within('header') { expect(page).to have_css('a', text: 'ユーザー検索') }
  end

  describe 'ログインしている場合' do
    let(:main_user) { create(:user) }
    before { browser_login(main_user) }

    it 'ドロップダウンメニュー用のボタンが存在する' do
      within('header') { expect(page).to have_css('a', text: main_user.name) }
    end

    describe 'ドロップダウンメニュー' do
      before do
        within('header') { click_on class: 'dropdown-toggle' }
      end

      it 'ドロップダウンメニューが存在する' do
        expect(page).to have_css('div', class: 'dropdown-menu', visible: true)
      end

      context 'マイページリンク' do
        it 'マイページへのリンクが存在する' do
          within('.dropdown-menu') do
            expect(page).to have_css('a', text: 'マイページ')
          end
        end
        it 'マイページへ遷移する' do
          within('.dropdown-menu') do
            click_on 'マイページ'
            expect(page).to have_title(main_user.name)
          end
        end
      end

      context 'ログアウトリンク' do
        it 'ログアウトへのリンクが存在する' do
          within('.dropdown-menu') do
            expect(page).to have_css('a', text: 'ログアウト')
          end
        end
        it 'ログアウトへ遷移する' do
          within('.dropdown-menu') do
            click_on 'ログアウト'
          end
          expect(page).to have_css('div', class: 'alert-success')
        end
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
