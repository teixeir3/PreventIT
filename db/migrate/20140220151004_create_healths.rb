class CreateHealths < ActiveRecord::Migration
  def change
    create_table :healths do |t|
      t.integer :patient_id, null: false
      t.float :height
      t.float :weight

      t.timestamps
    end

    add_index :healths, :patient_id
  end
end
