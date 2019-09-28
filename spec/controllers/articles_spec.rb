require 'rails_helper'

RSpec.describe 'ArticlesController', type: :request do
  let(:register) { create(:user, :with_articles, draft_count: 1) }
  let(:temporary) { create(:user, :temporary) }

  shared_examples_for 'HTTPリクエストが返る' do |status|
    it do
      subject.call
      expect(response).to have_http_status(status)
    end
  end

  shared_examples_for 'ログイン画面へリダイレクトする' do
    it do
      subject.call
      expect(response).to have_http_status(:found)
      expect(response).to redirect_to login_path
    end
  end

  shared_examples_for 'confirmation画面へリダイレクトする' do
    it do
      subject.call
      expect(response).to have_http_status(:found)
      expect(response).to redirect_to confirmation_users_path
    end
  end

  shared_examples_for '記事の詳細画面へリダイレクトする' do
    it do
      subject.call
      expect(response).to have_http_status(:found)
      expect(response).to redirect_to article_path(request_article)
    end
  end

  shared_examples_for 'Articleの総数が増える' do
    it { expect { subject.call }.to change { Article.count }.by(1) }
  end

  shared_examples_for 'Articleの総数が変わらない' do
    it { expect { subject.call }.to change { Article.count }.by(0) }
  end

  shared_examples_for 'Aricleの総数が減る' do
    it { expect { subject.call }.to change { Article.count }.by(-1) }
  end

  describe 'GET #index' do
    subject { proc { get articles_path } }
    it_behaves_like 'HTTPリクエストが返る', :success
  end

  describe 'GET #new' do
    subject { proc { get new_article_path } }

    context '本登録済みユーザーでログインしている場合' do
      before { login_request login_user }

      context '下書き10件以下の場合' do
        let(:login_user) { register }
        it_behaves_like 'HTTPリクエストが返る', :success
      end

      context '下書きが10件を超える場合' do
        let(:login_user) { create(:user, :with_articles, post_count: 0, draft_count: 10) }
        it '下書き画面へリダイレクトする' do
          subject.call
          expect(response).to have_http_status(:found)
          expect(response).to redirect_to drafts_path
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
    subject { proc { get article_path(request_article) } }

    context '投稿済みの記事の場合' do
      let(:request_article) { register.articles.posts.first }
      it_behaves_like 'HTTPリクエストが返る', :success
    end

    context '下書きの場合' do
      let(:request_article) { register.articles.drafts.first }
      it_behaves_like 'HTTPリクエストが返る', :not_found
    end
  end

  describe 'GET #edit' do
    let(:request_article) { register.articles.posts.first }
    subject { proc { get edit_article_path(request_article) } }

    context '本登録済みユーザーでログインしている場合' do
      before { login_request register }

      context 'ログインしているユーザーの記事へのリクエストの場合' do
        it_behaves_like 'HTTPリクエストが返る', :success
      end

      context 'ログインしているユーザー以外の記事へのリクエストの場合' do
        let(:request_article) { create(:user, :with_articles).articles.first }
        it_behaves_like 'HTTPリクエストが返る', :not_found
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
    subject { proc { get drafts_path } }

    context '本登録済みユーザーでログインしている場合' do
      before { login_request register }
      it_behaves_like 'HTTPリクエストが返る', :success
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
    subject { proc { post articles_path, params: { article: request_article.attributes } } }

    context '本登録済みユーザーでログインしている場合' do
      before { login_request register }
      it_behaves_like '記事の詳細画面へリダイレクトする'
      it_behaves_like 'Articleの総数が増える'
    end

    context '仮登録ユーザーでログインしている場合' do
      before { login_request temporary }
      it_behaves_like 'confirmation画面へリダイレクトする'
      it_behaves_like 'Articleの総数が変わらない'
    end

    context 'ログインしていない場合' do
      it_behaves_like 'ログイン画面へリダイレクトする'
      it_behaves_like 'Articleの総数が変わらない'
    end
  end

  describe 'PATCH #update' do
    let(:request_article) { register.articles.first }
    subject { proc { patch article_path(request_article), params: { article: attributes_for(:article) } } }

    context '本登録済みユーザーでログインしている場合' do
      before { login_request register }
      it_behaves_like '記事の詳細画面へリダイレクトする'
      it_behaves_like 'Articleの総数が変わらない'
    end

    context '仮登録ユーザーでログインしている場合' do
      before { login_request temporary }
      it_behaves_like 'confirmation画面へリダイレクトする'
      it_behaves_like 'Articleの総数が変わらない'
    end

    context 'ログインしていない場合' do
      it_behaves_like 'ログイン画面へリダイレクトする'
      it_behaves_like 'Articleの総数が変わらない'
    end
  end

  describe 'DELETE #destroy' do
  end
end
