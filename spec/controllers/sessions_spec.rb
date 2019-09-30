require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  let(:register) { create(:user) }
  let(:temporary) { create(:user, :temporary) }
  let(:posted_article) { register.articles.create(attributes_for(:article)) }

  shared_examples_for 'HTTPリクエストが返る' do |status|
    it { is_expected.to eq status }
  end

  shared_examples_for 'ログイン画面へリダイレクトする' do
    it_behaves_like 'HTTPリクエストが返る', 302
    it { is_expected.to redirect_to login_path }
  end

  shared_examples_for 'マイページへリダイレクトする' do
    it_behaves_like 'HTTPリクエストが返る', 302
    it { is_expected.to redirect_to user_path(request_user) }
  end

  shared_examples_for '直前にアクセスしたページへリダイレクトする' do
    before { get recent_access_path }

    context '記事詳細からのアクセスの場合' do
      let(:recent_access_path) { article_path(posted_article) }
      it_behaves_like 'HTTPリクエストが返る', 302
      it { is_expected.to redirect_to recent_access_path }
    end

    context 'ユーザー詳細からのアクセスの場合' do
      let(:recent_access_path) { user_path(register) }
      it_behaves_like 'HTTPリクエストが返る', 302
      it { is_expected.to redirect_to recent_access_path }
    end
  end

  describe 'GET #new' do
    subject { get login_path }

    context '本登録済みユーザーでログインしている場合' do
      let(:request_user) { register }
      before { login_request register }
      it_behaves_like 'マイページへリダイレクトする'
    end

    context '仮登録ユーザーでログインしている場合' do
      let(:request_user) { temporary }
      before { login_request temporary }
      it_behaves_like 'マイページへリダイレクトする'
    end

    context 'ログインしていない場合' do
      it_behaves_like 'HTTPリクエストが返る', 200
    end
  end

  describe 'POST #create' do
    subject { post login_path, params: { session: { email: request_user.email,
                                                    password: request_user.password,
                                                    remember_check: '0' } } }

    context '本登録済みユーザーでログインしている場合' do
      let(:request_user) { register }
      before { login_request register }
      it_behaves_like 'マイページへリダイレクトする'
    end

    context '仮登録ユーザーでログインしている場合' do
      let(:request_user) { temporary }
      before { login_request temporary }
      it_behaves_like 'マイページへリダイレクトする'
    end

    context 'ログインしていない場合' do
      context '登録済みのユーザーの値でリクエストする場合' do
        let(:request_user) { register }
        it_behaves_like '直前にアクセスしたページへリダイレクトする'
      end

      context '登録していないのユーザーの値でリクエストする場合' do
        let(:request_user) { build(:user) }
        it_behaves_like 'HTTPリクエストが返る', 200
      end
    end
  end

  describe 'DELETE #destroy' do
    subject { delete logout_path }

    context '本登録済みユーザーでログインしている場合' do
      before { login_request register }
      it_behaves_like '直前にアクセスしたページへリダイレクトする'
    end

    context '仮登録ユーザーでログインしている場合' do
      before { login_request temporary }
      it_behaves_like '直前にアクセスしたページへリダイレクトする'
    end

    context 'ログインしていない場合' do
      it_behaves_like 'ログイン画面へリダイレクトする'
    end
  end
end
