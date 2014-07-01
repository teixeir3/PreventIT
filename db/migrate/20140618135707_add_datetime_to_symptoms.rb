class AddDatetimeToSymptoms < ActiveRecord::Migration
  def change
    add_column :symptoms, :datetime, :datetime, null: false
    add_index :symptoms, :datetime
  end
end
