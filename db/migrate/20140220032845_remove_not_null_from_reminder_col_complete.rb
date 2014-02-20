class RemoveNotNullFromReminderColComplete < ActiveRecord::Migration
  def change
    remove_column :reminders, :complete
    add_column :reminders, :complete, :boolean
  end
end
