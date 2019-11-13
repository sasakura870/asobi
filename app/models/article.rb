class Article < ApplicationRecord
  # after_create :create_id_digest

  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user
  has_many :comments, dependent: :destroy
  has_many :comment_users, through: :comments, source: :user
  has_many :tag_maps, as: :taggable, dependent: :destroy
  has_many :tags, through: :tag_maps

  validates :title, presence: true, length: { maximum: 140 }
  validates :overview, length: { maximum: 140 }
  # validates :content, presence: true
  validates :user_id, presence: true
  validates :tag_maps, length: { maximum: 10, message: 'タグの最大数は10個です' }

  enum status: { draft: 0, published: 1 }

  has_rich_text :content

  scope :recent, -> { order(updated_at: :desc) }
  scope :search_title, ->(q) { where('title iLIKE ?', "%#{q}%") if q.present? }

  def to_param
    id_digest
  end

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def link_tag(tag_list)
    if new_record?
      tags << tag_list
    else
      map = []
      tag_list.each do |tag|
        map << tag_maps.build(tag_id: tag.id)
      end
      TagMap.import map
    end
  end

  def unlink_tag(tag)
    map = tag_maps.find_by(tag_id: tag.id)
    map.destroy
  end

  def create_id_digest
    new_digest = Digest::MD5.hexdigest(id.to_s)
    update_column(:id_digest, new_digest)
    # if id_digest.nil?
    # end
  end

  # private
end
