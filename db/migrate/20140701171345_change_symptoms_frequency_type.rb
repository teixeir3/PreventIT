class ChangeSymptomsFrequencyType < ActiveRecord::Migration
  def change
    remove_column :symptoms, :frequency
    add_column :symptoms, :frequency, :string
  end
end
