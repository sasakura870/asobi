class TagMap < ApplicationRecord
  belongs_to :taggable, polymorphic: true
  belongs_to :tag

  validates :tag_id, uniqueness: { scope: %i[taggable_id taggable_type] }
end
