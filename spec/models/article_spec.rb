require 'rails_helper'

RSpec.describe Article, type: :model do
  let(:main_user) { create(:user) }

  describe 'モデルの検証' do
    let(:main_article) { main_user.articles.build(attributes_for(:article)) }

    shared_examples_for 'validationエラー' do
      it { expect(main_article).to_not be_valid }
    end

    context '正常な値の場合' do
      it 'データベースへの登録が成功する' do
        expect(main_article).to be_valid
      end
    end

    describe 'title属性' do
      context 'nilの場合' do
        before { main_article.title = nil }
        it_behaves_like 'validationエラー'
      end

      context '140字以上の場合' do
        before { main_article.title = 'a' * 141 }
        it_behaves_like 'validationエラー'
      end
    end

    describe 'overview属性' do
      context '140字以上の場合' do
        before { main_article.overview = 'a' * 141 }
        it_behaves_like 'validationエラー'
      end
    end

    describe 'content属性' do
      context 'nilの場合' do
        before { main_article.content = nil }
        it_behaves_like 'validationエラー'
      end
    end

    describe 'user_id属性' do
      context 'nilの場合' do
        before { main_article.user_id = nil }
        it_behaves_like 'validationエラー'
      end
    end

    describe 'posted属性'
    describe 'thumbnail属性'
  end

  describe 'メソッドの動作確認'
end
