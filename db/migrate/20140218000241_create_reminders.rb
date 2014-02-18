class CreateReminders < ActiveRecord::Migration
  def change
    create_table :reminders do |t|
      t.string :day, null: false
      t.time :time, null: false
      t.string :title, null: false
      t.string :rem_type, null: false
      t.integer :input
      t.integer :patient_id, null: false
      t.boolean :complete, null: false, default: false
      t.text :note
      t.timestamps
    end

    add_index :reminders, :patient_id
  end
end