class CreateAppointmentTypes < ActiveRecord::Migration
  def change
    create_table :appointment_types do |t|
      t.string :name, null: false
      t.boolean :recurrence, null: false, default: false
      t.integer :occurence_frequency

      t.timestamps
    end
  end
end
