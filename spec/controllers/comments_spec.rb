require 'rails_helper'

RSpec.describe 'Comments', type: :request do
  let(:register) { create(:user, :with_articles, post_count: 1, draft_count: 1) }
  let(:temporary) { create(:user, :temporary) }
  let(:post_article) { register.articles.posts.first }
  let(:draft_article) { register.articles.drafts.first }

  describe 'POST #create' do
    let(:comment_params) { { article_id: request_article.id, content: 'test' } }
    let(:request_article) { post_article }
    subject { post comments_path params: { comment: comment_params } }

    context '本登録済みユーザーでログインしている場合' do
      before { login_request register }

      context '投稿済みの記事の場合' do
        it_behaves_like 'HTTPリクエストが返る', 302
        it_behaves_like 'モデルの総数が増える', Comment
      end

      context '下書きの場合' do
        let(:request_article) { draft_article }
        it_behaves_like 'HTTPリクエストが返る', 422
        # it_behaves_like 'モデルの総数が変わらない', Comment
      end
    end

    context '仮登録ユーザーでログインしている場合' do
      before { login_request temporary }
      it_behaves_like 'confirmation画面へリダイレクトする'
    end

    context 'ログインしていない場合' do
      it_behaves_like 'ログイン画面へリダイレクトする'
    end
  end

  describe 'DELETE #destroy' do
    let!(:comment) { register.comments.create(article_id: post_article.id, content: 'test') }
    subject { delete comment_path(comment) }

    context '本登録済みユーザーでログインしている場合' do
      before { login_request register }

      context '自分のコメントの場合' do
        it_behaves_like 'HTTPリクエストが返る', 302
        it_behaves_like 'モデルの総数が減る', Comment
      end

      context '他のユーザーのコメントの場合' do
        let(:sub_register) { create(:user) }
        let(:comment) { sub_register.comments.create(article_id: post_article.id, content: 'test') }
        it_behaves_like 'HTTPリクエストが返る', 422
      end
    end

    context '仮登録ユーザーでログインしている場合' do
      before { login_request temporary }
      it_behaves_like 'confirmation画面へリダイレクトする'
    end

    context 'ログインしていない場合' do
      it_behaves_like 'ログイン画面へリダイレクトする'
    end
  end
end
