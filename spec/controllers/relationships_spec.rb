require 'rails_helper'

RSpec.describe 'Relationships', type: :request do
  let(:main_register) { create(:user) }
  let(:sub_register) { create(:user) }
  let(:temporary) { create(:user, :temporary) }

  describe 'POST #create' do
    let(:request_user) { sub_register }
    subject { post relationships_path(user_id: request_user.id) }

    context '本登録済みユーザーでログインしている場合' do
      before { login_request main_register }

      context '自分自身へのリクエストの場合' do
        let(:request_user) { main_register }
        it_behaves_like 'HTTPリクエストが返る', 422
      end

      context '他の本登録済みユーザーへのリクエストの場合' do
        context 'フォローしている場合' do
          before { create_follow(main_register, sub_register) }
          it_behaves_like 'HTTPリクエストが返る', 422
        end

        context 'フォローしていない場合' do
          it_behaves_like 'HTTPリクエストが返る', 201
          it_behaves_like 'モデルの総数が増える', Relationship
        end
      end

      context '仮登録ユーザーへのリクエストの場合' do
        let(:request_user) { temporary }
        it_behaves_like 'HTTPリクエストが返る', 422
        it_behaves_like 'モデルの総数が変わらない', Relationship
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
    let(:request_user) { sub_register }
    subject { delete relationship_path(0, user_id: request_user.id) }

    context '本登録済みユーザーでログインしている場合' do
      before { login_request main_register }

      context '自分自身へのリクエストの場合' do
        let(:request_user) { main_register }
        it_behaves_like 'HTTPリクエストが返る', 422
      end

      context '他の本登録済みユーザーへのリクエストの場合' do
        context 'フォローしている場合' do
          before { create_follow(main_register, sub_register) }
          it_behaves_like 'HTTPリクエストが返る', 200
          it_behaves_like 'モデルの総数が減る', Relationship
        end

        context 'フォローしていない場合' do
          it_behaves_like 'HTTPリクエストが返る', 422
        end
      end

      context '仮登録ユーザーへのリクエストの場合' do
        let(:request_user) { temporary }
        it_behaves_like 'HTTPリクエストが返る', 422
        it_behaves_like 'モデルの総数が変わらない', Relationship
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