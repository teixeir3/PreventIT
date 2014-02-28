class CreateApptTypeDiagnoses < ActiveRecord::Migration
  def change
    create_table :appt_type_diagnoses do |t|
      t.integer :appt_type_id, null: false
      t.integer :diagnosis_id, null: false
      t.timestamps
    end

    add_index :appt_type_diagnoses, :appt_type_id
    add_index :appt_type_diagnoses, :diagnosis_id
    add_index :appt_type_diagnoses, [:appt_type_id, :diagnosis_id]
  end
end
