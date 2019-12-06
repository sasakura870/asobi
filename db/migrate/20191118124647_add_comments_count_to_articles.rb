class AddCommentsCountToArticles < ActiveRecord::Migration[6.0]
  def up
    add_column :articles, :comments_count, :integer, null: false, default: 0
  end

  def down
    remove_column :articles, :comments_count
  end
end
