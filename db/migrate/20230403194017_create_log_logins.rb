class CreateLogLogins < ActiveRecord::Migration[7.0]
  def change
    create_table :log_logins do |t|
      t.references :user, null: false, foreign_key: true
      t.string :status

      t.timestamps
    end
  end
end
