class AddDefaultToRemindersRemindableType < ActiveRecord::Migration
  def change
    change_column :reminders, :remindable_type, :string, null: false, default: "Other"
  end
end
