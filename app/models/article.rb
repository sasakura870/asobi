class Article < ApplicationRecord
  after_save :create_id_digest

  belongs_to :user

  validates :title, presence: true, length: { maximum: 140 }
  validates :overview, length: { maximum: 140 }
  # validates :content, presence: true
  validates :user_id, presence: true

  # mount_uploader :thumbnail, ThumbnailUploader
  has_one_attached :thumbnail

  has_rich_text :content

  scope :recent, -> { order(created_at: :desc) }

  def to_param
    id_digest
  end

  private

  def create_id_digest
    if id_digest.nil?
      new_digest = Digest::MD5.hexdigest(id.to_s)
      update_column(:id_digest, new_digest)
    end
  end
end
