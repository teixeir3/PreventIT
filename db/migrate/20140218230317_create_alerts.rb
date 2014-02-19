class CreateAlerts < ActiveRecord::Migration
  def change
    create_table :alerts do |t|
      t.integer :patient_id, null: false
      t.string :alert_type, null: false
      t.boolean :complete, null: false, default: false
      t.timestamps
    end

    add_index :alerts, :patient_id
  end
end
