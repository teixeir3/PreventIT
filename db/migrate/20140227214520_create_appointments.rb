class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.integer :patient_id, null: false
      t.integer :doctor_id
      t.datetime :datetime, null: false
      t.string :reason, null: false
      t.text :note
      t.boolean :met, null: false, default: false
      t.timestamps
    end

    add_index :appointments, :patient_id
  end
end
