class AddRemoveColsPatientMedication < ActiveRecord::Migration
  def change
    remove_column :patient_medications, :schedule
    remove_column :patient_medications, :dosage_num
    remove_column :patient_medications, :dosage_measurement
    remove_column :patient_medications, :duration_num
    remove_column :patient_medications, :duration_measurement
    remove_column :patient_medications, :num_type
    add_column :patient_medications, :description, :string
    add_column :patient_medications, :frequency, :integer
    add_column :patient_medications, :time_period, :string
  end
end
