class AddTreeStructureToReminders < ActiveRecord::Migration
  def change
    add_column  :reminders, :parent_id, :integer
    add_index :reminders, :parent_id
  end
end
