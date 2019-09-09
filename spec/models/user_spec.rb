require 'rails_helper'

RSpec.describe User, type: :model do
  let(:main_user) { build(:user) }

  describe 'モデルの検証' do
    shared_examples_for 'validationエラー' do
      it { expect(main_user).to_not be_valid }
    end

    context '正常な値で登録する場合' do
      it 'データベースへの登録が成功する' do
        expect { main_user.save! }.to change { User.count }.by(1)
      end
    end

    describe 'name属性' do
      context '値がnullの場合' do
        before { main_user.name = nil }
        it_behaves_like 'validationエラー'
      end

      context '32文字以上の場合' do
        before { main_user.name = 'a' * 33 }
        it_behaves_like 'validationエラー'
      end

      context '既に登録されているnameの場合' do
        let!(:sub_user) { create(:user) }
        it_behaves_like 'validationエラー'
      end
    end

    describe 'email属性' do
      context '値がnullの場合' do
        before { main_user.email = nil }
        it_behaves_like 'validationエラー'
      end

      context 'email形式のフォーマットではない値の場合' do
        before { main_user.email = 'bad_email' }
        it_behaves_like 'validationエラー'
      end

      context '既に登録されているemailの場合' do
        let!(:sub_user) { create(:user) }
        it_behaves_like 'validationエラー'
      end
    end

    describe 'password属性' do
      context 'passwordがnullの場合' do
        before { main_user.password = nil }
        it_behaves_like 'validationエラー'
      end

      context 'passwordが8文字以下の場合' do
        before do
          main_user.password = 'badpass'
          main_user.password_confirmation = 'badpass'
        end
        it_behaves_like 'validationエラー'
      end

      context 'passwordが16文字以上の場合' do
        before do
          main_user.password = 'a' * 17
          main_user.password_confirmation = 'a' * 17
        end
        it_behaves_like 'validationエラー'
      end

      context 'passwordとpassword_confirmationが違う値の場合' do
        before { main_user.password_confirmation = 'badpassword' }
        it_behaves_like 'validationエラー'
      end
    end
  end

  describe 'メソッドの動作確認' do
    context 'emailを大文字で登録した場合' do
      before do
        main_user.email.upcase!
        main_user.save
      end

      it 'emailが小文字で登録される' do
        expect(main_user.email).to_not match(/[A-Z]/)
      end
    end
  end
end
