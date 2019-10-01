require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:register) { create(:user, :with_articles, draft_count: 1) }
  let(:post_article) { register.articles.posts.first }
  let(:draft_article) { register.articles.drafts.first }

  describe 'validation' do
    subject { article.comments.build(params)}

    context '正常な値の場合' do
      let(:article) { post_article }
      let(:params) { { user_id: register.id, content: 'test' } }
      it_behaves_like 'validation通過'
    end

    context 'contentがnilの場合' do
      let(:article) { post_article }
      let(:params) { { user_id: register.id, content: nil } }
      it_behaves_like 'validationエラー'
    end

    context '下書きにコメントする場合' do
      let(:article) { draft_article }
      let(:params) { { user_id: register.id, content: 'test' } }
      it_behaves_like 'validationエラー'
    end
  end
end
