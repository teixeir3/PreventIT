class CreateReminderEvents < ActiveRecord::Migration
  def change
    create_table :reminder_events do |t|
      t.integer :reminder_id, null: false
      t.integer :metric
      t.text :note
      t.boolean :complete, null: false, default: false

      t.timestamps
    end

    add_index :reminder_events, :reminder_id
  end
end
