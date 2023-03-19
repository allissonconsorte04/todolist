class AddLoginTokenAndLoginCountToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :login_token, :string
    add_column :users, :login_count, :integer, default: 0
  end
end
