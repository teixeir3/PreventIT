class AddDoctorIdToApptType < ActiveRecord::Migration
  def change
    add_column :appointment_types, :doctor_id, :integer, null: false
    add_index :appointment_types, :doctor_id
  end
end
