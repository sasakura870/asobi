require 'rails_helper'

RSpec.describe Article, type: :model do
  describe 'validation' do
    let(:main_user) { create(:user) }
    subject { main_user.articles.build(attributes_for(:article)) }

    context '正常な値の場合' do
      it_behaves_like 'validation通過'
    end

    describe 'title属性' do
      context 'nilの場合' do
        before { subject.title = nil }
        it_behaves_like 'validationエラー'
      end

      context '140文字の場合' do
        before { subject.title = 'a' * 140 }
        it_behaves_like 'validation通過'
      end

      context '141文字の場合' do
        before { subject.title = 'a' * 141 }
        it_behaves_like 'validationエラー'
      end
    end

    describe 'overview' do
      context '140文字の場合' do
        before { subject.overview = 'a' * 140 }
        it_behaves_like 'validation通過'
      end
      context '141文字の場合' do
        before { subject.overview = 'a' * 141 }
        it_behaves_like 'validationエラー'
      end
    end

    describe 'user_id' do
      context 'nilの場合' do
        before { subject.user_id = nil }
        it_behaves_like 'validationエラー'
      end
    end

    describe 'content'
    describe 'thumbnail'
  end

  describe 'メソッド' do
    let(:main_user) { create(:user, :with_articles, post_count: 1, draft_count: 1) }
    let(:post_article) { main_user.articles.posts.first }
    let(:draft_article) { main_user.articles.drafts.first }

    context '.to_param' do
      it 'id_digestを返す' do
        expect(post_article.to_param).to eq post_article.id_digest
      end
    end

    context '.post?' do
      it '投稿済みであればtrueを返す' do
        expect(post_article.post?).to be_truthy
        expect(draft_article.post?).to be_falsey
      end
    end

    context '.draft?' do
      it '下書きであればtrueを返す' do
        expect(draft_article.draft?).to be_truthy
        expect(post_article.draft?).to be_falsey
      end
    end

    context '.favorited_by?' do
      let(:sub_user) { create(:user, :with_articles, post_count: 1) }
      let(:sub_post_article) { sub_user.articles.first }
      before { create_favorite(main_user, sub_post_article) }

      it '引数のユーザーいいねされているユーザーであればtrueを返す' do
        expect(sub_post_article.favorited_by?(main_user)).to be_truthy
        expect(post_article.favorited_by?(sub_user)).to be_falsey
      end
    end
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
      let(:q) { 'text' }
      it 'タイトルに検索文字が含まれる記事のみ取得する' do
        expect(test_case.search_title(q).count).to eq 5
      end
    end
  end
end
