class ChangeAppointmentsTable < ActiveRecord::Migration
  def change
    add_column :appointments, :appointment_type_id, :integer
    remove_column :appointments, :reason
  end
end
