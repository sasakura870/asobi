class AddArticlesCountToUsers < ActiveRecord::Migration[6.0]
  def up
    add_column :users, :articles_count, :integer, null: false, default: 0
  end

  def down
    remove_column :users, :articles_count
  end
end
