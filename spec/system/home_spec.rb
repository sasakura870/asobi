require 'rails_helper'

RSpec.describe 'Home画面', type: :system do
  before do
    visit root_path
  end

  it 'Home画面に遷移する' do
    expect(page).to have_title('Asobi')
  end

  context '新規登録ボタンを押す' do
    before do
      click_on '新規登録'
    end

    it '新規登録画面へ遷移する' do
      expect(page).to have_title('新規登録')
    end
  end
end
