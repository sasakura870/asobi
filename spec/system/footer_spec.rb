require 'rails_helper'

RSpec.describe 'footer' do
  before { visit root_path }

  it 'Copyrightが存在する' do
    within('footer') { expect(page).to have_content('Copyright') }
  end
  context 'Aboutリンク' do
    it '「Asobiとは」のリンクが存在する' do
      within('footer') { expect(page).to have_css('a', text: 'Asobiとは') }
    end
    it 'About画面へ遷移する' do
      within('footer') { click_on 'Asobiとは' }
      expect(page).to have_title('Asobiとは')
    end
  end

  context 'termsリンク' do
    it '利用規約のリンクが存在する' do
      within('footer') { expect(page).to have_css('a', text: '利用規約') }
    end
    it '利用規約へ遷移する' do
      within('footer') { click_on '利用規約' }
      expect(page).to have_title('利用規約')
    end
  end

  context 'privacyリンク' do
    it 'プライバシーポリシーのリンクが存在する' do
      within('footer') { expect(page).to have_css('a', text: 'プライバシーポリシー') }
    end
    it 'プライバシーポリシーへ遷移する' do
      within('footer') { click_on 'プライバシーポリシー' }
      expect(page).to have_title('プライバシーポリシー')
    end
  end

  context 'ヘルプリンク' do
    it 'ヘルプのリンクが存在する' do
      within('footer') { expect(page).to have_css('a', text: 'ヘルプ') }
    end
    it 'help画面へ遷移する' do
      within('footer') { click_on 'ヘルプ' }
      expect(page).to have_title('ヘルプ')
    end
  end

  context 'ユーザー一覧リンク' do
    it 'ユーザー一覧のリンクが存在する' do
      within('footer') { expect(page).to have_css('a', text: 'ユーザー一覧') }
    end
    it 'ユーザー一覧へ遷移する' do
      within('footer') { click_on 'ユーザー一覧' }
      expect(page).to have_title('ユーザー一覧')
    end
  end
end