require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:register) { create(:user, :with_articles) }
  let(:main_article) { register.articles.first }

  # TODO 下書きはエラー
  # TODO コメントなしはエラー
end
