class Article < ApplicationRecord
  after_save :create_id_digest

  belongs_to :user

  validates :title, presence: true, length: { maximum: 140 }
  validates :overview, length: { maximum: 140 }
  # validates :content, presence: true
  validates :user_id, presence: true

  has_one_attached :thumbnail

  has_rich_text :content

  scope :fair_copy, -> { where(posted: true) }
  scope :draft, -> { where(posted: false) }
  scope :recent, -> { order(created_at: :desc) }
  scope :search_title, ->(q) { where('title iLIKE ?', "%#{q}%") if q.present? }

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
