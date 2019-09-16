require 'rails_helper'

RSpec.describe '検索機能' do
  let(:main_user) { create(:user) }
  let(:sub_user) { create(:user_faker) }
  let(:q) { 'test' }

  before do
    # 10.times do |n|
    #   main_user.articles.create(attributes_for(:article) { title: q + n.to_s } )
    #   sub_user.articles.create(attributes_for(:article) { title: q + n.to_s } )
    # end
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
    count = Article.fair_copy.search_title(q).count
    expect(page).to have_content("#{count}件")
  end
  # TODO 画面に検索にヒットした件数が表示される

  # TODO 記事がヒットした場合
    # TODO 入力した値が含まれる記事が表示される
    # TODO 大文字小文字を無視する

  # TODO 検索結果が0件の場合
    # TODO 見つからなかった旨のテキストが表示される
end