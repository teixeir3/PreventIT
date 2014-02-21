class AddInputCheckedColtoReminders < ActiveRecord::Migration
  def change
    add_column :reminders, :input_checked, :boolean, null: false, default: false
  end
end
