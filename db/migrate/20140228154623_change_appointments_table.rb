class ChangeAppointmentsTable < ActiveRecord::Migration
  def change
    add_column :appointments, :appointment_type_id
    drop_column :appointments, :reason
  end
end
