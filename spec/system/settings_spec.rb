require 'rails_helper'

RSpec.describe 'setting画面' do
  let(:main_user) { create(:user) }

  before do
    browser_login(main_user)
    visit settings_path
  end

  it '各入力フォームに、main_userの値が入力されている' do
    expect(page).to have_css('input', id: 'user_name')
  end
end
