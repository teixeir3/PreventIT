class AddProviderAndAccessTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :access_token, :string
    add_column :users, :provider, :string
    add_index :users, [:uid, :provider], unique: true
  end
end
