class CreatePatientDiagnoses < ActiveRecord::Migration
  def change
    create_table :patient_diagnoses do |t|
      t.integer :diagnosis_id, null: false
      t.integer :patient_id, null: false

      t.timestamps
    end

    add_index :patient_diagnoses, :diagnosis_id
    add_index :patient_diagnoses, :patient_id
    add_index :patient_diagnoses, [:diagnosis_id, :patient_id], unique: true
  end
end
