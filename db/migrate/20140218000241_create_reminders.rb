class CreateReminders < ActiveRecord::Migration
  def change
    create_table :reminders do |t|
      t.datetime :datetime, null: false
      t.string :title, null: false
      t.string :rem_type, null: false
      t.integer :input
      t.integer :patient_id, null: false
      t.boolean :complete, null: false, default: false
      t.boolean :due, null: false, default: true
      t.text :note
      t.timestamps
    end

    add_index :reminders, :patient_id
  end
end
