class CreateMedications < ActiveRecord::Migration
  def change
    create_table :medications do |t|
      t.string :name, null: false
      t.timestamps
    end
    
    add_index :medications, :name
  end
end
