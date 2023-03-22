class CreateUserValidationTokens < ActiveRecord::Migration[7.0]
  def change
    create_table :user_validation_tokens do |t|
      t.references :user, null: false, foreign_key: true
      t.references :validation_token, null: false, foreign_key: true

      t.timestamps
    end

    add_index :user_validation_tokens, %i[user_id validation_token_id], unique: true
  end
end
