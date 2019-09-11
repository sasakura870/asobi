class Article < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: { maximum: 140 }
  validates :overview, length: { maximum: 140 }
  validates :content, presence: true
  validates :user_id, presence: true

  mount_uploader :thumbnail, ThumbnailUploader

  scope :recent, -> { order(created_at: :desc) }

  # Base64でハッシュ化されるため、URLに使えない
  # def encrypt_id
  #   Rails.application.message_verifier(ENV['ASOBI_ARTICLE_ID_VERIFIER_PASSWORD']).generate(id)
  # end
end
