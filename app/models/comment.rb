class Comment < ApplicationRecord
  # before_destroy :only_my_comment

  belongs_to :user
  belongs_to :article

  validates :content, presence: true
  validate :only_post

  private

  def only_post
    article = Article.find_by(id: article_id)
    errors.add(:draft, '下書きにはコメントできません') if article&.draft?
  end
end
