require 'rails_helper'

RSpec.describe 'Comments', type: :request do
  let(:main_register) { create(:user, :with_articles, post_count: 1) }
  let(:sub_register) { create(:user, :with_articles, post_count: 1, draft_count: 1) }
  let(:temporary) { create(:user, :temporary) }
  let(:main_post) { main_register.articles.posts.first }
  let(:sub_post) { sub_register.articles.posts.first }
  let(:sub_draft) { sub_register.articles.drafts.first }

  describe 'POST #create' do
    context '本登録済みユーザーでログインしている場合' do
      context '自分の記事の場合'
      context '他のユーザーの記事の場合'
      context '他のユーザーの下書きの場合'
    end
    context '仮登録ユーザーでログインしている場合' do
      context '自分の記事の場合'
      context '他のユーザーの記事の場合'
      context '他のユーザーの下書きの場合'
    end
    context 'ログインしていない場合'
  end
  describe 'DELETE #destroy'
end
