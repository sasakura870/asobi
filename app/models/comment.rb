class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :article
  counter_culture :article

  validates :content, presence: true
  validate :only_post

  scope :lately, -> { order(:created_at) }

  private

  def only_post
    article = Article.find_by(id: article_id)
    errors.add(:draft, '下書きにはコメントできません') if article&.draft?
  end
end
