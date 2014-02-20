class AddSubTypeColToRemindersAndAddReasonToAlerts < ActiveRecord::Migration
  def change

    add_column :alerts, :reason, :string
    add_column :reminders, :sub_type, :string
  end
end
