require 'rails_helper'

RSpec.describe 'ArticlesController', type: :request do
  let(:register) { create(:user, :with_articles, draft_count: 1) }
  let(:temporary) { create(:user, :temporary) }

  shared_examples_for '記事の詳細画面へリダイレクトする' do
    it { is_expected.to redirect_to article_path(request_article) }
  end

  describe 'GET #index' do
    subject { get articles_path }
    it_behaves_like 'HTTPリクエストが返る', 200
  end

  describe 'GET #new' do
    subject { get new_article_path }

    context '本登録済みユーザーでログインしている場合' do
      before { login_request login_user }

      context '下書き10件以下の場合' do
        let(:login_user) { register }
        it_behaves_like 'HTTPリクエストが返る', 200
      end

      context '下書きが10件を超える場合' do
        let(:login_user) { create(:user, :with_articles, post_count: 0, draft_count: 10) }
        it '下書き画面へリダイレクトする' do
          is_expected.to redirect_to drafts_path
        end
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

  describe 'GET #show' do
    subject { get article_path(request_article) }

    context '投稿済みの記事の場合' do
      let(:request_article) { register.articles.posts.first }
      it_behaves_like 'HTTPリクエストが返る', 200
    end

    context '下書きの場合' do
      let(:request_article) { register.articles.drafts.first }
      it_behaves_like 'HTTPリクエストが返る', 404
    end
  end

  describe 'GET #edit' do
    let(:request_article) { register.articles.posts.first }
    subject { get edit_article_path(request_article) }

    context '本登録済みユーザーでログインしている場合' do
      before { login_request register }

      context 'ログインしているユーザーの記事へのリクエストの場合' do
        it_behaves_like 'HTTPリクエストが返る', 200
      end

      context 'ログインしているユーザー以外の記事へのリクエストの場合' do
        let(:request_article) { create(:user, :with_articles).articles.first }
        it_behaves_like 'HTTPリクエストが返る', 404
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

  describe 'GET #drafts' do
    subject { get drafts_path }

    context '本登録済みユーザーでログインしている場合' do
      before { login_request register }
      it_behaves_like 'HTTPリクエストが返る', 200
    end

    context '仮登録ユーザーでログインしている場合' do
      before { login_request temporary }
      it_behaves_like 'confirmation画面へリダイレクトする'
    end

    context 'ログインしていない場合' do
      it_behaves_like 'ログイン画面へリダイレクトする'
    end
  end

  describe 'GET #favorites' do
  end

  describe 'POST #create' do
    let(:request_article) { build(:article) }
    subject { post articles_path, params: { article: request_article.attributes } }

    context '本登録済みユーザーでログインしている場合' do
      before { login_request register }
      it_behaves_like 'HTTPリクエストが返る', 302
      it_behaves_like 'モデルの総数が増える', Article
    end

    context '仮登録ユーザーでログインしている場合' do
      before { login_request temporary }
      it_behaves_like 'confirmation画面へリダイレクトする'
      it_behaves_like 'モデルの総数が変わらない', Article
    end

    context 'ログインしていない場合' do
      it_behaves_like 'ログイン画面へリダイレクトする'
      it_behaves_like 'モデルの総数が変わらない', Article
    end
  end

  describe 'PATCH #update' do
    let!(:request_article) { register.articles.first }
    subject { patch article_path(request_article), params: { article: attributes_for(:article) } }

    context '本登録済みユーザーでログインしている場合' do
      before { login_request register }
      it_behaves_like '記事の詳細画面へリダイレクトする'
      it_behaves_like 'モデルの総数が変わらない', Article
    end

    context '仮登録ユーザーでログインしている場合' do
      before { login_request temporary }
      it_behaves_like 'confirmation画面へリダイレクトする'
      it_behaves_like 'モデルの総数が変わらない', Article
    end

    context 'ログインしていない場合' do
      it_behaves_like 'ログイン画面へリダイレクトする'
      it_behaves_like 'モデルの総数が変わらない', Article
    end
  end

  describe 'DELETE #destroy' do
  end
end
