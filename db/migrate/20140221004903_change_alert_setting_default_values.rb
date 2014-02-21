class ChangeAlertSettingDefaultValues < ActiveRecord::Migration
  def change
    remove_column :alert_settings, :bmi_min
    remove_column :alert_settings, :bmi_max
    add_column :alert_settings, :bmi_min, :float, null: false, default: 18
    add_column :alert_settings, :bmi_max, :float, null: false, default: 30
  end
end
