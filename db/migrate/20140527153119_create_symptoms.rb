class CreateSymptoms < ActiveRecord::Migration
  def change
    create_table :symptoms do |t|
      t.string :name, null: false
      t.integer :patient_id, null: false
      t.text :description
      t.integer :intensity
      t.integer :frequency
      t.timestamps
    end
    
    add_index :symptoms, :patient_id
  end
end
