class AddEmailNotificationsColToUsersTable < ActiveRecord::Migration
  def change

    add_column :users, :email_notifications, :boolean, null: false, default: true
  end
end
