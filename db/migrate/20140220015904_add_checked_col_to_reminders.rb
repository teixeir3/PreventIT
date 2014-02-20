class AddCheckedColToReminders < ActiveRecord::Migration
  def change
    add_column :reminders, :checked, :boolean, null: false, default: false
  end
end
