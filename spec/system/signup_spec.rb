require 'rails_helper'

RSpec.describe '新規登録画面' do
  before do
    visit signup_path
  end

  it '入力フォームが4つ存在する' do
    expect(page).to have_css('div', class: 'input-form', count: 4)
  end

  describe '新規登録' do
    let(:signup_user) { FactoryBot.build(:user) }

    before do
      fill_in 'user_name', with: signup_user.name
      fill_in 'user_email', with: signup_user.email
      fill_in 'user_password', with: signup_user.password
      fill_in 'user_password_confirmation', with: confirmation
      click_on '登録する'
    end

    shared_examples_for '登録に失敗する' do
      it do
        expect(page).to have_title('新規登録')
        expect(page).to have_css('div', class: 'alert-danger')
      end
    end

    context '正しい値を入力した場合' do
      let(:confirmation) { signup_user.password }
      it '登録が完了する' do
        expect(page).to have_css('div', class: 'alert-success')
      end
      it '自分のユーザー画面に遷移する(仮)' do
        expect(page).to have_title(signup_user.name)
      end
    end

    context '確認用パスワードの入力値を誤った場合' do
      let(:confirmation) { 'badpassword' }
      it_behaves_like '登録に失敗する'
    end
  end
end