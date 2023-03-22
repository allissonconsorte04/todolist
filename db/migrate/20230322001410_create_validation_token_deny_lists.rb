class CreateValidationTokenDenyLists < ActiveRecord::Migration[7.0]
  def change
    create_table :validation_token_deny_lists do |t|
      t.references :validation_token, null: false, foreign_key: true, unique: true

      t.timestamps
    end
  end
end
