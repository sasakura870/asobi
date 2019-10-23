class Tag < ApplicationRecord
  has_many :tag_map
  has_many :users, through: :tag_map, source: :taggable, source_type: 'User'
  has_many :articles, through: :tag_map, source: :taggable, source_type: 'Article'

  validates :name, presence: true,
                   uniqueness: true,
                   length: { maximum: 140 }
end
