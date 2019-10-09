require 'rails_helper'

RSpec.describe 'ログイン画面' do
  let(:main_user) { create(:user) }
  before { visit login_path }

  # TODO 新規登録画面に遷移する
  # TODO パスワード再設定画面に遷移する

  describe 'ログイン機能' do
    let(:email) { main_user.email }
    let(:password) { main_user.password }
    before do
      fill_in 'session_email', with: email
      fill_in 'session_password', with: password
      click_on 'ログイン'
    end

    describe '入力値の検証' do
      shared_examples_for 'ログインに失敗する' do
        it do
          expect(page).to have_title('ログイン')
          expect(page).to have_css('div', class: 'alert-danger')
        end
      end

      context '正しい値を入力した場合' do
        it 'ログインに成功する' do
          expect(page).to have_css('div', class: 'alert-success')
        end
      end

      context '誤ったメールアドレスを入力した場合' do
        let(:email) { 'bademail@example.com' }
        it_behaves_like 'ログインに失敗する'
      end

      context '誤ったパスワードを入力した場合' do
        let(:password) { 'badpassword' }
        it_behaves_like 'ログインに失敗する'
      end
    end
  end

  describe 'remember_me機能' do
    before do
      fill_in 'session_email', with: main_user.email
      fill_in 'session_password', with: main_user.password
      remember_action
      click_on 'ログイン'
      expire_cookies
      visit user_path(main_user)
    end

    context '使用して再起動する場合' do
      let(:remember_action) { check 'ログイン状態を保持する', visible: false }
      it { expect(page).to have_checked_field("ログイン状態を保持する") }
      it '再起動後もログインしている' do
        within('header') { expect(page).to have_link 'dropdown_profile' }
      end
    end

    context '使用せず再起動する場合' do
      let(:remember_action) {}
      it '再起動後はログアウトしている' do
        within('header') { expect(page).to have_link 'ログイン' }
      end
    end
  end
end
