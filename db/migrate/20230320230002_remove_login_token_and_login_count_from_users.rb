class RemoveLoginTokenAndLoginCountFromUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :login_token, :string
    remove_column :users, :login_count, :integer
  end
end
