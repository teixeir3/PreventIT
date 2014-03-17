class RemoveReminderRemTypeCol < ActiveRecord::Migration
  def change
    add_index :reminders, :remindable_id
    remove_column :reminders, :rem_type
  end
end
