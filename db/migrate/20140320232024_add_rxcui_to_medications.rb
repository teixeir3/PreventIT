class AddRxcuiToMedications < ActiveRecord::Migration
  def change
    add_column :medications, :rxcui, :integer
    add_index :medications, :rxcui
  end
end
