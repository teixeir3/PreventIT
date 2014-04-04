class AddColToPatientMed < ActiveRecord::Migration
  def change
    add_column :patient_medications, :num_taken, :integer
    add_column :patient_medications, :num_type, :string
    add_column :patient_medications, :schedule, :string
  end
end
