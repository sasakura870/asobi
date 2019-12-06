require 'rails_helper'

RSpec.describe 'user#show' do
  let(:main_user) { create(:user) }

  before { visit user_path(main_user.name) }

  it 'タイトルにユーザー名が含まれる' do
    expect(page).to have_title(main_user.name)
  end

  # TODO: サイドメニュー
  # TODO アイコンがある
  # TODO ニックネーム
  # TODO ある場合はある
  # TODO ない場合はない
  # TODO IDがある
  # TODO 自己紹介文
  # TODO ある場合はある
  # TODO ない場合はない
  # TODO フォローボタン
  # TODO 自分のページ
  # TODO ない
  # TODO 自分以外のページ
  # TODO ある
  # TODO フォローしている場合
  # TODO フォローしているみため
  # TODO おす
  # TODO フォローが外れる
  # TODO フォローしていない場合
  # TODO フォローしていないみため
  # TODO おす
  # TODO フォローする
  # TODO フォロー数が実際の値と一致する
  # TODO フォロワー数が実際の値と一致する
  # TODO 人気の記事のランキングがある
  # メイン
  # 記事一覧が表示される
  # ページネーションがある
end
