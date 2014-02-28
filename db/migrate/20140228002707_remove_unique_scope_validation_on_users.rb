class RemoveUniqueScopeValidationOnUsers < ActiveRecord::Migration
  def change
    remove_index :users, [:uid, :provider]
    add_index :users, [:uid, :provider]
  end
end
