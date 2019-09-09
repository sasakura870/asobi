require 'rails_helper'

RSpec.describe 'ログイン画面' do
  let(:main_user) { create(:user) }

  before do
    visit login_path
  end

  it '入力フォームが2つ存在する' do
    expect(page).to have_css('input', class: 'form-control', count: 2)
  end

  describe 'ログイン' do
    before do
      fill_in 'session_email', with: main_user.email
      fill_in 'session_password', with: password
      click_on 'ログイン'
    end

    shared_examples_for 'ログインに失敗する' do
      it do
        expect(page).to have_title('ログイン')
        expect(page).to have_css('div', class: 'alert-danger')
      end
    end

    context '正しい値を入力する' do
      let(:password) { main_user.password }
      it 'ログインに成功する' do
        expect(page).to have_css('div', class: 'alert-success')
      end
    end

    context '誤ったパスワードを入力する' do
      let(:password) { 'badpassword' }
      it_behaves_like 'ログインに失敗する'
    end
  end
end
