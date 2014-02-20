class AddColsToAlertSettings < ActiveRecord::Migration
  def change
    add_column :alert_settings, :skipped_treatments, :integer, null: false, default: 2
    add_column :alert_settings, :skipped_inputs, :integer, null: false, default: 2
  end
end
