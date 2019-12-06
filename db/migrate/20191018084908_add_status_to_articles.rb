class AddStatusToArticles < ActiveRecord::Migration[6.0]
  def change
    add_column :articles, :status, :integer, null: false, default: 0, index: true
  end
end
