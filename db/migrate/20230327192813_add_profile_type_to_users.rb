class AddProfileTypeToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :profile_type, :integer, null: false, default: 0
  end
end
