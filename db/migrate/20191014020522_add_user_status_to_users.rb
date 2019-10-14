class AddUserStatusToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :status, :integer
  end
end
