class CreateLoginTokens < ActiveRecord::Migration[6.1]
  def change
    create_table :login_tokens do |t|
      t.string :login_token
      t.integer :login_count
      t.datetime :expires_at
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
