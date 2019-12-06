class AddIndexToNameFromTag < ActiveRecord::Migration[6.0]
  def change
    add_index :tags, :name
  end
end
