class AddUniqueValidationToApptTypeDiagnoses < ActiveRecord::Migration
  def change
    remove_index :appt_type_diagnoses, [:appt_type_id, :diagnosis_id]
    add_index :appt_type_diagnoses, [:appt_type_id, :diagnosis_id], unique: true
  end
end
