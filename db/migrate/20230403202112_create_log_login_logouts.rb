class CreateLogLoginLogouts < ActiveRecord::Migration[7.0]
  def change
    create_table :log_login_logouts do |t|
      t.references :user, null: false, foreign_key: true
      t.string :status

      t.timestamps
    end
  end
end