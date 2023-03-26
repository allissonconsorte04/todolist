class AddShowPhoneToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :show_phone, :boolean, default: false, null: false
  end
end
