class CreateLogProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :log_profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :event
      t.json :modifications, null: false

      t.timestamps
    end
  end
end
