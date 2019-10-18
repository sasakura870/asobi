class AddStatusIndexToArticles < ActiveRecord::Migration[6.0]
  def change
    add_index :articles, :status
  end
end
