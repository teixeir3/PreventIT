class AddIndextoDiagnosis < ActiveRecord::Migration
  def change
    add_index :diagnoses, :code, unique: true
    add_index :diagnoses, :description, unique: true
  end
end
