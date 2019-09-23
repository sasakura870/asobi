require 'rails_helper'

RSpec.describe Favorite, type: :model do
  let(:main_user) do
    create(:user, :with_articles, post_count: 1, draft_count: 1)
  end
  let(:sub_user) do
    create(:user, :with_articles, post_count: 1, draft_count: 1)
  end
  let(:main_post) { main_user.articles.posts.first }
  let(:main_draft) { main_user.articles.drafts.first }
  let(:sub_post) { sub_user.articles.posts.first }
  let(:sub_draft) { sub_user.articles.drafts.first }

  describe 'validation' do
    context 'ユーザーが他のユーザーが投稿した記事にいいねする場合' do
      it 'データベースへの登録が成功する' do
        expect(build_favorite(main_user, sub_post)).to be_valid
        expect { create_favorite(main_user, sub_post) }.to change { Favorite.count }.by(1)
      end
    end

    context '既に登録済みの組み合わせのユーザー、記事の場合' do
      before { create_favorite(main_user, sub_post) }
      it 'validationエラー' do
        expect(build_favorite(main_user, sub_post)).to_not be_valid
      end
    end

    context 'ユーザーが自分で投稿した記事の場合' do
      it 'validationエラー' do
        expect(build_favorite(main_user, main_post)).to_not be_valid
      end
    end

    context '下書きの場合' do
      it 'validationエラー' do
        expect(build_favorite(main_user, sub_draft)).to_not be_valid
      end
    end
  end
end
