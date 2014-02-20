class CreateAlertSettings < ActiveRecord::Migration
  def change
    create_table :alert_settings do |t|
      t.integer :doctor_id, null: false
      t.integer :skipped_meds, null: false, default: 2
      t.integer :skipped_appointments, null: false, default: 2
      t.float :bmi_min, null: false, default: 18.4
      t.float :bmi_max, null: false, default: 25
      t.float :a1c_min, null: false, default: 18.4
      t.float :a1c_max, null: false, default: 25
      t.timestamps
    end
  end
end
