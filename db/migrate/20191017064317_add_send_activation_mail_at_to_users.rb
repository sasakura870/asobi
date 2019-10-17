class AddSendActivationMailAtToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :send_activation_mail_at, :datetime
  end
end
