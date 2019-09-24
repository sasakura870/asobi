class Article < ApplicationRecord
  after_save :create_id_digest

  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user

  validates :title, presence: true, length: { maximum: 140 }
  validates :overview, length: { maximum: 140 }
  # validates :content, presence: true
  validates :user_id, presence: true

  has_one_attached :thumbnail

  has_rich_text :content

  scope :posts, -> { where(posted: true) }
  scope :drafts, -> { where(posted: false) }
  scope :recent, -> { order(updated_at: :desc) }
  scope :search_title, ->(q) { where('title iLIKE ?', "%#{q}%") if q.present? }

  def to_param
    id_digest
  end

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  private

  def create_id_digest
    if id_digest.nil?
      new_digest = Digest::MD5.hexdigest(id.to_s)
      update_column(:id_digest, new_digest)
    end
  end
end
