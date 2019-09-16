require 'rails_helper'

RSpec.describe 'article#show' do
  let(:main_user) { create(:user) }
  let(:main_article) { main_user.articles.create(attributes_for(:article)) }

  before do
    visit article_path(main_article)
  end

  it 'タイトルに記事のタイトルが含まれる' do
    expect(page).to have_title(main_article.title)
  end

  # TODO アイコンメニュー
    # TODO いいねボタンがある
  # TODO サイドメニュー
  # TODO 本文
    # TODO タイトルがある
    # TODO 投稿日がある
    # TODO 作成者のリンクがある
    # TODO タグがある
    # TODO 概要
      # TODO ある場合はある
      # TODO ない場合はない
    # TODO サムネイル
      # TODO ある場合はある
      # TODO ない場合はデフォルト
    # TODO contentsがある
      # 画像がある
      # TODO 色々うまくいってる
    # TODO いいね数がある
    # TODO コメント数がある
    # TODO タイトルがある
    # TODO 投稿日がある
    # TODO 作成者のリンクがある
  # TODO コメント欄
    # TODO コメント投稿フォームがある
    # TODO コメントが表示されている
    # TODO コメント
      # TODO 投稿者のリンクがある
      # TODO 投稿日がある
      # TODO 本文がある
end
