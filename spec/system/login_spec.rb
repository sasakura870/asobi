require 'rails_helper'

RSpec.describe 'ログイン画面' do
  let(:main_user) { create(:user) }
  before { visit login_path }

  it '入力フォームが2つ存在する' do
    expect(page).to have_css('input', class: 'form-control', count: 2)
  end
  it 'ログイン状態の保持用のチェックボックスが存在する' do
    expect(page).to have_field 'ログイン状態を保持する'
  end

  # TODO 新規登録リンクが存在する
  # TODO 新規登録画面に遷移する
  # TODO パスワード再設定用のリンクが存在する
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
end
