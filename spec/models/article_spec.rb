require 'rails_helper'

RSpec.describe Article, type: :model do
  let(:main_user) { create(:user) }

  describe 'validation' do
    let(:main_article) { main_user.articles.build(attributes_for(:article)) }

    shared_examples_for 'validationエラー' do
      it { expect(main_article).to_not be_valid }
    end

    context '正常な値の場合' do
      it 'データベースへの登録が成功する' do
        expect(main_article).to be_valid
      end
    end

    describe 'title' do
      context 'nilの場合' do
        before { main_article.title = nil }
        it_behaves_like 'validationエラー'
      end

      context '140字以上の場合' do
        before { main_article.title = 'a' * 141 }
        it_behaves_like 'validationエラー'
      end
    end

    describe 'overview' do
      context '140字以上の場合' do
        before { main_article.overview = 'a' * 141 }
        it_behaves_like 'validationエラー'
      end
    end

    describe 'user_id' do
      context 'nilの場合' do
        before { main_article.user_id = nil }
        it_behaves_like 'validationエラー'
      end
    end

    describe 'content'
    describe 'posted'
    describe 'thumbnail'
  end

  # TODO describe '.to_param'
end
