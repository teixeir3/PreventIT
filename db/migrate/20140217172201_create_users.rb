class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :password_digest, null: false
      t.string :session_token, null: false
      t.string :first_name
      t.string :last_name
      t.string :phone
      t.integer :doctor_id
      t.integer :practice_id
      t.boolean :is_doctor, null: false, default: false

      t.timestamps
    end

    add_index :users, :doctor_id
  end
end
