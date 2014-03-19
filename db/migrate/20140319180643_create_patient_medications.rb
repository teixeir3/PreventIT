class CreatePatientMedications < ActiveRecord::Migration
  def change
    create_table :patient_medications do |t|
      t.integer :patient_id, null: false
      t.integer :medication_id, null: false
      t.integer :pt_diagnosis_id
      t.datetime :start_date
      t.datetime :end_date
      t.integer :refills, null: false, default: 0
      t.integer :count
      t.float :dosage_num
      t.string :dosage_measurement
      t.integer :duration_num
      t.string :duration_measurement
      
      t.timestamps
    end
    
    add_index :patient_medications, :patient_id
    add_index :patient_medications, :medication_id
    add_index :patient_medications, [:patient_id, :medication_id]
    add_index :patient_medications, :pt_diagnosis_id
  end
end
