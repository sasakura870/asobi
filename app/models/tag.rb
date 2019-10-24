class Tag < ApplicationRecord
  has_many :tag_maps, dependent: :destroy
  has_many :users, through: :tag_maps, source: :taggable, source_type: 'User'
  has_many :articles, through: :tag_maps, source: :taggable, source_type: 'Article'

  validates :name, presence: true,
                   uniqueness: true,
                   length: { maximum: 140 }

  def to_param
    name
  end
end
