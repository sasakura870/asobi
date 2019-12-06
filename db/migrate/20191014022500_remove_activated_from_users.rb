class RemoveActivatedFromUsers < ActiveRecord::Migration[6.0]
  def up
    remove_column :users, :activated
  end

  def down
    add_column :users, :activated, :boolean, default: false
  end
end
