require 'rails_helper'

RSpec.describe 'UsersController', type: :request do
  let(:register) { create(:user) }
  let(:temporary) { create(:user, :temporary) }

  # describe 'GET #index' do
  #   subject { get users_path }
  #   it_behaves_like 'HTTPリクエストが返る', 200
  # end

  describe 'GET #new' do
    subject { get signup_path }

    context '本登録済みユーザーでログインしている場合' do
      let(:request_user) { register }
      before { login_request request_user }
      it_behaves_like 'マイページへリダイレクトする'
    end

    context '仮登録ユーザーでログインしている場合' do
      let(:request_user) { temporary }
      before { login_request request_user }
      it_behaves_like 'マイページへリダイレクトする'
    end

    context 'ログインしていない場合' do
      it_behaves_like 'HTTPリクエストが返る', 200
    end
  end

  describe 'GET #show' do
    context '本登録済みユーザーのページの場合' do
      subject { get user_path(register) }
      it_behaves_like 'HTTPリクエストが返る', 200
    end

    context '仮登録ユーザーのページの場合' do
      subject { get user_path(temporary) }
      it_behaves_like 'HTTPリクエストが返る', 404

      context '仮登録ユーザーがマイページにアクセスする場合' do
        before { login_request temporary }
        it_behaves_like 'HTTPリクエストが返る', 200
      end
    end
  end

  describe 'GET #edit' do
    subject { get settings_path }

    context '本登録済みユーザーでログインしている場合' do
      before { login_request register }
      it_behaves_like 'HTTPリクエストが返る', 200
    end

    context '仮登録ユーザーでログインしている場合' do
      before { login_request temporary }
      it_behaves_like 'HTTPリクエストが返る', 200
    end

    context 'ログインしていない場合' do
      it_behaves_like 'ログイン画面へリダイレクトする'
    end
  end

  describe 'POST #create' do
    let(:user_params) { attributes_for(:user) }
    subject { post users_path, params: { user: user_params } }

    context '本登録済みユーザーでログインしている場合' do
      let(:request_user) { register }
      before { login_request request_user }
      it_behaves_like 'マイページへリダイレクトする'
    end

    context '仮登録ユーザーでログインしている場合' do
      let(:request_user) { temporary }
      before { login_request request_user }
      it_behaves_like 'マイページへリダイレクトする'
    end

    context 'ログインしていない場合' do
      context '正常な値を送信した場合' do
        it_behaves_like 'confirmation画面へリダイレクトする'
        it_behaves_like 'モデルの総数が増える', User
      end

      context '検証に通らない値を送信した場合' do
        let(:user_params) { attributes_for(:user, email: '') }
        it_behaves_like 'モデルの総数が変わらない', User
      end
    end
  end

  describe 'PATCH #update' do
    subject { patch user_path(patched_user), params: { user: user_params } }

    shared_examples_for 'ログインしてユーザー情報の編集' do
      before { login_request request_user }

      context 'ログイン中のユーザーの値を更新する場合' do
        let(:patched_user) { request_user }

        context '正常な値の場合' do
          let(:user_params) { request_user.attributes }
          it_behaves_like 'セッティング画面へリダイレクトする'
          it_behaves_like 'モデルの総数が変わらない', User
        end

        context '検証に通らない値を送信した場合' do
          let(:user_params) do
            request_user.name = ''
            request_user.attributes
          end
          it_behaves_like 'HTTPリクエストが返る', 200
          it_behaves_like 'モデルの総数が変わらない', User
        end
      end

      context 'ログイン中のユーザーと異なるユーザーの値を更新する場合' do
        let(:patched_user) { other_user }
        let(:user_params) { attributes_for(:user) }
        it_behaves_like 'HTTPリクエストが返る', 422
      end
    end

    context '本登録済みユーザーでログインしている場合' do
      let(:request_user) { register }
      let(:other_user) { temporary }
      it_behaves_like 'ログインしてユーザー情報の編集'
    end

    context '仮登録ユーザーでログインしている場合' do
      let(:request_user) { temporary }
      let(:other_user) { register }
      it_behaves_like 'ログインしてユーザー情報の編集'
    end

    context 'ログインしていない場合' do
      let(:patched_user) { register }
      let(:user_params) { register.attributes }
      it_behaves_like 'ログイン画面へリダイレクトする'
    end
  end

  describe 'DELETE #destroy' do
  end

  describe 'GET #confirmation' do
    subject { get confirmation_users_path }

    context '本登録済みユーザーでログインしている場合' do
      let(:request_user) { register }
      before { login_request request_user }
      it_behaves_like 'マイページへリダイレクトする'
    end

    context '仮登録ユーザーでログインしている場合' do
      before { login_request temporary }
      it_behaves_like 'HTTPリクエストが返る', 200
    end

    context 'ログインしていない場合' do
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
