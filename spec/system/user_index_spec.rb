require 'rails_helper'

RSpec.describe 'ユーザー一覧画面' do
  let!(:main_user) { FactoryBot.create(:user) }

  before do
    70.times do |n|
      FactoryBot.create(:user_faker, name: "faker#{n}")
    end
    visit users_path
  end

  it 'タイトルに「ユーザー一覧」が含まれる' do
    expect(page).to have_title('ユーザー一覧')
  end

  it 'ページネーションが存在する' do
    expect(page).to have_css('nav', class: 'pagination', visible: false)
  end

  context 'ユーザーメディア' do
    it 'ユーザーへのリンクがある' do
      expect(page).to have_css('a', text: main_user.name)
    end

    it '自己紹介文がある' do
      within "li#user_#{main_user.name}" do
        expect(page).to have_css('p')
      end
    end
  end
end