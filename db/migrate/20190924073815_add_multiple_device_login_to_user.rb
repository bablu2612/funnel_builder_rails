class AddMultipleDeviceLoginToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :duplicate_login_token, :string
  end
end
