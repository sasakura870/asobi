require 'rails_helper'

RSpec.describe 'Favorites', type: :request do
  let(:main_register) { create(:user, :with_articles, post_count: 1) }
  let(:sub_register) { create(:user, :with_articles, post_count: 1, draft_count: 1) }
  let(:temporary) { create(:user, :temporary) }
  let(:main_post) { main_register.articles.posts.first }
  let(:sub_post) { sub_register.articles.posts.first }
  let(:sub_draft) { sub_register.articles.drafts.first }

  describe 'POST #create' do
    subject { post favorites_path(article_id: article_id) }

    context '本登録済みユーザーでログインしている場合' do
      before { login_request main_register }

      context '自分の記事の場合' do
        let(:article_id) { main_post.id }
        it_behaves_like 'HTTPリクエストが返る', 422
      end

      context '他のユーザーの記事の場合' do
        let(:article_id) { sub_post.id }

        context 'いいねしていない記事の場合' do
          it_behaves_like 'HTTPリクエストが返る', 302
          it_behaves_like 'モデルの総数が増える', Favorite
        end

        context '既にいいねしている場合' do
          before { create_favorite(main_register, sub_post) }
          it_behaves_like 'HTTPリクエストが返る', 422
          it_behaves_like 'モデルの総数が変わらない', Favorite
        end
      end

      context '他のユーザーの下書きの場合' do
        let(:article_id) { sub_draft.id }
        it_behaves_like 'HTTPリクエストが返る', 422
      end
    end

    context '仮登録ユーザーでログインしている場合' do
      let(:article_id) { main_post.id }
      before { login_request temporary }
      it_behaves_like 'confirmation画面へリダイレクトする'
    end

    context 'ログインしていない場合' do
      let(:article_id) { main_post.id }
      it_behaves_like 'ログイン画面へリダイレクトする'
    end
  end

  describe 'DELETE #destroy' do
    subject { delete favorite_path(0, article_id: article_id) }

    context '本登録済みユーザーでログインしている場合' do
      before { login_request main_register }

      context '自分の記事の場合' do
        let(:article_id) { main_post.id }
        it_behaves_like 'HTTPリクエストが返る', 422
      end

      context '他のユーザーの記事の場合' do
        let(:article_id) { sub_post.id }

        context 'いいねしていない記事の場合' do
          it_behaves_like 'HTTPリクエストが返る', 422
          it_behaves_like 'モデルの総数が変わらない', Favorite
        end

        context '既にいいねしている場合' do
          before { create_favorite(main_register, sub_post) }
          it_behaves_like 'HTTPリクエストが返る', 302
          it_behaves_like 'モデルの総数が減る', Favorite
        end
      end
    end

    context '仮登録ユーザーでログインしている場合' do
      let(:article_id) { main_post.id }
      before { login_request temporary }
      it_behaves_like 'confirmation画面へリダイレクトする'
    end

    context 'ログインしていない場合' do
      let(:article_id) { main_post.id }
      it_behaves_like 'ログイン画面へリダイレクトする'
    end
  end
end
