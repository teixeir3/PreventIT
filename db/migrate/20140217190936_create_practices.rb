class CreatePractices < ActiveRecord::Migration
  def change
    create_table :practices do |t|
      t.string :specialty, null: false
      t.string :name, null: false

      t.timestamps
    end
  end
end
