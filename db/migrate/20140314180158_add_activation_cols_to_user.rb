class AddActivationColsToUser < ActiveRecord::Migration
  def change
    add_column :users, :active, :boolean, default: false, :null => false
    add_column :users, :activation_token, :string, default: "INACTIVE", :null => false
  end
end
