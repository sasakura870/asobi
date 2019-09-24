require 'rails_helper'

RSpec.describe '検索機能' do
  let(:main_user) { create(:user) }
  let(:sub_user) { create(:user_faker) }
  let(:q) { 'text' }

  before do
    20.times do
      main_user.articles.create(attributes_for(:article))
      sub_user.articles.create(attributes_for(:article))
    end
    visit root_path
    within 'header' do
      fill_in 'search-text', with: q
      find_field('search-text').send_keys(:enter)
    end
  end

  it '検索画面へ遷移する' do
    expect(page).to have_title(q)
  end

  it '画面に検索にヒットした件数が表示される' do
    count = Article.posts.search_title(q).count
    expect(page).to have_content("#{count}件")
  end

  it '入力した値が含まれる記事が表示される' do
    within first('.card-deck') do
      expect(page).to have_link(q)
    end
  end

  it 'ページネーションが存在する' do
    expect(page).to have_css('ul', class: 'pagination', visible: false)
  end

  context 'アルファベットを大文字で入力した場合' do
    let(:q) { 'TEXT' }
    it '大文字、小文字を無視して検索する' do
      expect(page).to have_css('div', class: 'card-deck')
    end
  end

  context '検索結果が0件の場合' do
    let(:q) { 'badquery' }
    it '見つからなかった旨のテキストが表示される' do
      expect(page).to have_content('見つかりませんでした')
    end
  end
end
