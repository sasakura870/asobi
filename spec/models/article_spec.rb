require 'rails_helper'

RSpec.describe Article, type: :model do
  let(:main_user) { create(:user) }
  let(:main_article) { main_user.articles.build(attributes_for(:article)) }

  describe 'validation' do
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

  describe 'メソッド' do
    context '.to_param' do
      it 'id_digestを返す' do
        expect(main_article.to_param).to eq main_article.id_digest
      end
    end
    # TODO context 'faborited_by?'
  end

  describe 'スコープ' do
    let(:test_user) do
      create(:user, :with_articles, post_count: 3, draft_count: 2)
    end

    subject(:test_case) { test_user.articles }

    context 'recent' do
      it '先頭に一番新しい記事がある' do
        expect(test_case.recent.first).to eq test_case.last
      end
    end

    context 'drafts' do
      it '下書きの記事のみ取得する' do
        expect(test_case.drafts.count).to eq 2
      end
    end

    context 'posts' do
      it '投稿済みの記事のみ取得する' do
        expect(test_case.posts.count).to eq 3
      end
    end

    context 'search_title' do
      let(:q) { '3' }
      it 'タイトルに検索文字が含まれる記事のみ取得する' do
        expect(test_case.search_title(q).count).to eq 1
      end
    end
  end
end
