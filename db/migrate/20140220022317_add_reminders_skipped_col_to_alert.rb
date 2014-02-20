class AddRemindersSkippedColToAlert < ActiveRecord::Migration
  def change

    add_column :alerts, :reminders_skipped, :integer
  end
end
