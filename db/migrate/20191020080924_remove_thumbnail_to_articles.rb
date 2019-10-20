class RemoveThumbnailToArticles < ActiveRecord::Migration[6.0]
  def up
    remove_column :articles, :thumbnail
  end

  def down
    add_column :articles, :thumbnail, :string
  end
end
