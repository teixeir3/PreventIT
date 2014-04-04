class AddNoteToPatientMedications < ActiveRecord::Migration
  def change
    add_column :patient_medications, :note, :text
  end
end
