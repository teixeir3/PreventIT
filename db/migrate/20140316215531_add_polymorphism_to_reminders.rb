class AddPolymorphismToReminders < ActiveRecord::Migration
  def change
    add_column :reminders, :remindable_id, :integer
    add_column :reminders, :remindable_type, :string
  end
end
