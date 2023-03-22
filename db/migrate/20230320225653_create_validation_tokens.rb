class CreateValidationTokens < ActiveRecord::Migration[6.1]
  def change
    create_table :validation_tokens do |t|
      t.string :token
      t.datetime :expires_at, null: false
      t.datetime :sent_at

      t.timestamps
    end
  end
end
