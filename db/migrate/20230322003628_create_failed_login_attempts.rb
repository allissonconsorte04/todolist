class CreateFailedLoginAttempts < ActiveRecord::Migration[7.0]
  def change
    create_table :failed_login_attempts do |t|
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
