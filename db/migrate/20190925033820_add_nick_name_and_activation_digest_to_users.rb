class AddNickNameAndActivationDigestToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :nick_name, :string
    add_column :users, :activated, :boolean, default: false
    add_column :users, :activation_digest, :string
  end
end
