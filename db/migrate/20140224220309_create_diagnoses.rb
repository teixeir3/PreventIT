class CreateDiagnoses < ActiveRecord::Migration
  def change
    create_table :diagnoses do |t|
      t.string :code, null: false
      t.text :description, null: false
      t.string :code_type, null: false, default: "ICD10"

      t.timestamps
    end
  end
end
