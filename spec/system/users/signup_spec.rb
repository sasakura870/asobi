require 'rails_helper'

RSpec.describe '新規登録画面' do
  before { visit signup_path }
  it '入力フォームが4つ存在する' do
    expect(page).to have_css('input', class: 'form-control', count: 4)
  end

  # TODO ログインリンクが存在する
  # TODO ログイン画面へ遷移する

  describe '新規登録' do
    let(:signup_user) { build(:user) }
    let(:confirmation) { signup_user.password }

    before do
      fill_in 'user_name', with: signup_user.name
      fill_in 'user_email', with: signup_user.email
      fill_in 'user_password', with: signup_user.password
      fill_in 'user_password_confirmation', with: confirmation
      click_on '登録する'
    end

    describe '入力値の検証' do
      shared_examples_for '登録に失敗する' do
        it do
          expect(page).to have_title('新規登録')
          expect(page).to have_css('div', class: 'alert-danger')
        end
      end

      context '正しい値を入力した場合' do
        it '登録完了のalertが表示される' do
          expect(page).to have_css('div', class: 'alert-success')
        end
        it '自分のユーザー画面に遷移する(仮)' do
          expect(page).to have_title(signup_user.name)
        end
      end

      # TODO 誤った情報を入力した場合
        # TODO 新規登録画面へ遷移する
        # TODO 登録失敗のalertが表示される
        # TODO エラーメッセージが表示される

      # context '誤った確認用パスワードを入力した場合' do
      #   let(:confirmation) { 'badpassword' }
      #   it_behaves_like '登録に失敗する'
      # end
    end
  end
end