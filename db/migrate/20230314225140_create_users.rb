class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false, unique: true
      t.string :phone, null: false, unique: true
      t.string :cpf, null: false, unique: true
      t.string :gender, null: false
      t.string :profile_type, null: false

      t.timestamps
    end
    add_index :users, :cpf, unique: true
  end
end
