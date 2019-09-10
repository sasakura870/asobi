require 'rails_helper'

RSpec.describe 'user#show' do
  let(:main_user) { create(:user) }

  before { visit user_path(main_user.name) }

  it 'タイトルにユーザー名が含まれる' do
    expect(page).to have_title(main_user.name)
  end
end
