require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validation' do
    subject { build(:user, :temporary) }

    describe 'name属性' do
      context 'nullの場合' do
        before { subject.name = nil }
        it_behaves_like 'validationエラー'
      end

      describe 'length' do
        context '3文字の場合' do
          before { subject.name = 'aaa' }
          it_behaves_like 'validationエラー'
        end
        context '4文字以上の場合' do
          before { subject.name = 'aaaa' }
          it_behaves_like 'validation通過'
        end
        context '16文字の場合' do
          before { subject.name = 'a' * 16 }
          it_behaves_like 'validation通過'
        end
        context '17文字以上の場合' do
          before { subject.name = 'a' * 17 }
          it_behaves_like 'validationエラー'
        end
      end

      context '使用できない文字が入っている場合' do
        before { subject.name = '%&$():a' }
        it_behaves_like 'validationエラー'
      end

      context '既に登録されているnameの場合' do
        before { create(:user, name: subject.name) }
        it_behaves_like 'validationエラー'
      end
    end

    describe 'email属性' do
      context '値がnullの場合' do
        before { subject.email = nil }
        it_behaves_like 'validationエラー'
      end

      context 'email形式のフォーマットではない値の場合' do
        before { subject.email = 'bad_email' }
        it_behaves_like 'validationエラー'
      end

      context '既に登録されているemailの場合' do
        before { create(:user, email: subject.email) }
        it_behaves_like 'validationエラー'
      end
    end

    describe 'password属性' do
      context 'passwordがnullの場合' do
        before { subject.password = nil }
        it_behaves_like 'validationエラー'
      end

      describe 'length' do
        before do
          subject.password = value
          subject.password_confirmation = value
        end

        context 'passwordが7文字の場合' do
          let(:value) { 'badpass' }
          it_behaves_like 'validationエラー'
        end
        context 'passwordが8文字の場合' do
          let(:value) { 'goodpass' }
          it_behaves_like 'validation通過'
        end
        context 'passwordが72文字の場合' do
          let(:value) { 'a' * 72 }
          it_behaves_like 'validation通過'
        end
        context 'passwordが73文字の場合' do
          let(:value) { 'a' * 73 }
          it_behaves_like 'validationエラー'
        end
      end

      context '使用できない文字が入っている場合' do
        before do
          value = '+;:/?][{}¥|'
          subject.password = value
          subject.password_confirmation = value
        end

        it_behaves_like 'validationエラー'
      end

      context 'passwordとpassword_confirmationが異なる値の場合' do
        before { subject.password_confirmation = 'badpassword' }
        it_behaves_like 'validationエラー'
      end
    end

    describe 'introduction属性' do
      describe 'length' do
        context '140文字の場合' do
          before { subject.introduction = 'a' * 140 }
          it_behaves_like 'validation通過'
        end
        context '141文字の場合' do
          before { subject.introduction = 'a' * 141 }
          it_behaves_like 'validationエラー'
        end
      end
    end

    describe 'nick_name属性' do
      describe 'length' do
        context '50文字の場合' do
          before { subject.nick_name = 'a' * 50 }
          it_behaves_like 'validation通過'
        end
        context '51文字の場合' do
          before { subject.nick_name = 'a' * 51 }
          it_behaves_like 'validationエラー'
        end
      end
    end
    # TODO validationテストの追加
    describe 'photo属性'
  end

  describe 'メソッド' do
    subject { create(:user, :temporary) }

    context '.to_param' do
      it 'nameの値を返す' do
        expect(subject.to_param).to eq subject.name
      end
    end

    context '.signup_activation' do
      before { subject.signup_activation }
      it 'activatedの値をtrueにする' do
        expect(subject.activated).to be_truthy
      end
    end

    context '.register?' do
      let(:register) { create(:user) }
      it '本登録ユーザーであればtrueを返す' do
        expect(register.register?).to be_truthy
        expect(subject.register?).to be_falsey
      end
    end

    context '.temporary?' do
      let(:register) { create(:user) }
      it '仮登録ユーザーであればtrueを返す' do
        expect(register.temporary?).to be_falsey
        expect(subject.temporary?).to be_truthy
      end
    end

    context '.remember_me' do
      before { subject.remember_me }
      it 'remember_digestに値が入る' do
        expect(subject.remember_digest).to be_present
      end
    end

    context '.forget_me' do
      before { subject.forget_me }
      it 'remember_digestにnilが入る' do
        expect(subject.remember_digest).to be nil
      end
    end

    context '.already_favorite?' do
      let(:main_user) { create(:user, :with_articles, post_count: 1) }
      let(:post_article) { main_user.articles.posts.first }
      let(:sub_user) { create(:user, :with_articles, post_count: 1) }
      let(:sub_post_article) { sub_user.articles.first }
      before { create_favorite(main_user, sub_post_article) }

      it '引数の記事を既にいいねしていればtrueを返す' do
        expect(main_user.already_favorite?(sub_post_article)).to be_truthy
        expect(sub_user.already_favorite?(post_article)).to be_falsey
      end
    end

    context '.my_comment?' do
      let(:main_user) { create(:user, :with_articles, post_count: 1) }
      let(:sub_user) { create(:user, :with_articles, post_count: 1) }
      let(:post_article) { main_user.articles.posts.first }
      let!(:comment) { create_comment(main_user, post_article) }

      it '引数のコメントが自身のものであればtrueを返す' do
        expect(main_user.my_comment?(comment)).to be_truthy
        expect(sub_user.my_comment?(comment)).to be_falsey
      end
    end

    context '.already_follow?' do
      let(:main_user) { create(:user) }
      let(:sub_user) { create(:user) }
      before { create_follow(main_user, sub_user) }

      it '引数のユーザーをフォローしていればtrueを返す' do
        expect(main_user.already_follow?(sub_user)).to be_truthy
        expect(sub_user.already_follow?(main_user)).to be_falsey
      end
    end

    context '.followed_by?' do
      let(:main_user) { create(:user) }
      let(:sub_user) { create(:user) }
      before { create_follow(main_user, sub_user) }

      it '引数のユーザーをフォローしていればtrueを返す' do
        expect(sub_user.followed_by?(main_user)).to be_truthy
        expect(main_user.followed_by?(sub_user)).to be_falsey
      end
    end
  end

  describe 'コールバック' do
    subject { create(:user) }

    context 'データを作成した場合' do
      it 'activationトークンを発行する' do
        expect(subject.activation).to be_present
      end
    end

    context 'emailを大文字で登録した場合' do
      before do
        subject.email.upcase!
        subject.save
      end

      it 'emailが小文字で登録される' do
        expect(subject.email).to_not match(/[A-Z]/)
      end
    end
  end
end
