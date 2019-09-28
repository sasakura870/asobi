require 'rails_helper'

RSpec.describe 'UsersController', type: :request do
  let(:register) { create(:user) }
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
      expect(response).to redirect_to login_path
    end
  end

  shared_examples_for 'マイページへリダイレクトする' do
    it do
      subject.call
      expect(response).to redirect_to user_path(login_user)
    end
  end

  shared_examples_for 'セッティング画面へリダイレクトする' do
    it do
      subject.call
      expect(response).to redirect_to settings_path
    end
  end

  shared_examples_for 'モデルの総数が増える' do |model|
    it { expect { subject.call }.to change { model.count }.by(1) }
  end

  shared_examples_for 'モデルの総数が変わらない' do |model|
    it { expect { subject.call }.to change { model.count }.by(0) }
  end

  shared_examples_for 'モデルの総数が減る' do |model|
    it { expect { subject.call }.to change { model.count }.by(-1) }
  end

  describe 'GET #index' do
    subject { proc { get users_path } }
    it_behaves_like 'HTTPリクエストが返る', :success
  end

  describe 'GET #new' do
    subject { proc { get signup_path } }

    shared_examples_for 'リダイレクト' do
      before { login_request login_user }
      it_behaves_like 'HTTPリクエストが返る', :found
      it_behaves_like 'マイページへリダイレクトする'
    end

    context '本登録済みユーザーでログインしている場合' do
      let(:login_user) { register }
      it_behaves_like 'リダイレクト'
    end

    context '仮登録ユーザーでログインしている場合' do
      let(:login_user) { temporary }
      it_behaves_like 'リダイレクト'
    end

    context 'ログインしていない場合' do
      it_behaves_like 'HTTPリクエストが返る', :success
    end
  end

  describe 'GET #show' do
    context '本登録済みユーザーのページの場合' do
      subject { proc { get user_path(register) } }
      it_behaves_like 'HTTPリクエストが返る', :success
    end

    context '仮登録ユーザーのページの場合' do
      subject { proc { get user_path(temporary) } }
      it_behaves_like 'HTTPリクエストが返る', :not_found

      context '仮登録ユーザーがマイページにアクセスする場合' do
        before { login_request temporary }
        it_behaves_like 'HTTPリクエストが返る', :success
      end
    end
  end

  describe 'GET #edit' do
    subject { proc { get settings_path } }

    context '本登録済みユーザーでログインしている場合' do
      before { login_request register }
      it_behaves_like 'HTTPリクエストが返る', :success
    end

    context '仮登録ユーザーでログインしている場合' do
      before { login_request temporary }
      it_behaves_like 'HTTPリクエストが返る', :success
    end

    context 'ログインしていない場合' do
      it_behaves_like 'HTTPリクエストが返る', :found
      it_behaves_like 'ログイン画面へリダイレクトする'
    end
  end

  describe 'POST #create' do
    let(:user_params) { attributes_for(:user) }
    subject { proc { post users_path, params: { user: user_params } } }

    shared_examples_for 'リダイレクト' do
      before { login_request login_user }
      it_behaves_like 'HTTPリクエストが返る', :found
      it_behaves_like 'マイページへリダイレクトする'
    end

    context '本登録済みユーザーでログインしている場合' do
      let(:login_user) { register }
      it_behaves_like 'リダイレクト'
    end

    context '仮登録ユーザーでログインしている場合' do
      let(:login_user) { temporary }
      it_behaves_like 'リダイレクト'
    end

    context 'ログインしていない場合' do
      context '正常な値を送信した場合' do
        it_behaves_like 'HTTPリクエストが返る', :found
        it 'confirmation画面へリダイレクトする' do
          subject.call
          expect(response).to redirect_to confirmation_users_path
        end
        it_behaves_like 'モデルの総数が増える', User
      end

      context '検証に通らない値を送信した場合' do
        let(:user_params) { attributes_for(:user, email: '') }
        it_behaves_like 'HTTPリクエストが返る', :success
        it_behaves_like 'モデルの総数が変わらない', User
      end
    end
  end

  describe 'PATCH #update' do
    subject { proc { patch user_path(patched_user), params: { user: user_params } } }

    shared_examples_for 'ログインしてユーザー情報の編集' do
      before { login_request login_user }

      context 'ログイン中のユーザーの値を更新する場合' do
        let(:patched_user) { login_user }

        context '正常な値の場合' do
          let(:user_params) { login_user.attributes }
          it_behaves_like 'HTTPリクエストが返る', :found
          it_behaves_like 'セッティング画面へリダイレクトする'
          it_behaves_like 'モデルの総数が変わらない', User
        end

        context '検証に通らない値を送信した場合' do
          let(:user_params) do
            login_user.name = ''
            login_user.attributes
          end
          it_behaves_like 'HTTPリクエストが返る', :success
          it_behaves_like 'モデルの総数が変わらない', User
        end
      end

      context 'ログイン中のユーザーと異なるユーザーの値を更新する場合' do
        let(:patched_user) { other_user }
        let(:user_params) { attributes_for(:user) }
        it_behaves_like 'HTTPリクエストが返る', :unprocessable_entity
        it_behaves_like 'モデルの総数が変わらない', User
      end
    end

    context '本登録済みユーザーでログインしている場合' do
      let(:login_user) { register }
      let(:other_user) { temporary }
      it_behaves_like 'ログインしてユーザー情報の編集'
    end

    context '仮登録ユーザーでログインしている場合' do
      let(:login_user) { temporary }
      let(:other_user) { register }
      it_behaves_like 'ログインしてユーザー情報の編集'
    end

    context 'ログインしていない場合' do
      let(:patched_user) { register }
      let(:user_params) { register.attributes }
      it_behaves_like 'HTTPリクエストが返る', :found
      it_behaves_like 'ログイン画面へリダイレクトする'
    end
  end

  describe 'DELETE #destroy' do
  end

  describe 'GET #confirmation' do
    subject { proc { get confirmation_users_path } }

    context '本登録済みユーザーでログインしている場合' do
      let(:login_user) { register }
      before { login_request login_user }
      it_behaves_like 'HTTPリクエストが返る', :found
      it_behaves_like 'マイページへリダイレクトする'
    end

    context '仮登録ユーザーでログインしている場合' do
      before { login_request temporary }
      it_behaves_like 'HTTPリクエストが返る', :success
    end

    context 'ログインしていない場合' do
      it_behaves_like 'HTTPリクエストが返る', :found
      it_behaves_like 'ログイン画面へリダイレクトする'
    end
  end

  describe 'GET #followings' do
  end
  describe 'GET #followers' do
  end
  describe 'GET #favorites' do
  end
  describe 'GET #notifications' do
  end
end
