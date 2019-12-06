class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :article
  counter_culture :article

  validates :article_id, uniqueness: { scope: :user_id }
  validate :cannot_favorite_yourself, :cannot_favorite_draft

  private

  def cannot_favorite_yourself
    article = Article.find_by id: article_id
    errors.add(:your_article, '自分の記事にいいねはできません') if article.user_id == user_id
  end

  def cannot_favorite_draft
    unless Article.find_by(id: article_id).published?
      errors.add(:draft, '下書きにいいねはできません')
    end
  end
end
