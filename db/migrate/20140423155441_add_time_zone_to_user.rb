class AddTimeZoneToUser < ActiveRecord::Migration
  def change
    add_column :users, :timezone, :string, null: false, default: "Eastern Time (US & Canada)"
  end
end
