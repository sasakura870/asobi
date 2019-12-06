class AddUserStatusToIndexAndDefault < ActiveRecord::Migration[6.0]
  def change
    add_index :users, :status
    change_column_null :users, :status, false
    change_column_default :users, :status, from: nil, to: 0
  end
end
