class RemovePostedToArticles < ActiveRecord::Migration[6.0]
  def up
    remove_column :articles, :posted
  end

  def down
    add_column :articles, :posted, :boolean, defalut: false
  end
end
