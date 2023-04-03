class CreateLogActivities < ActiveRecord::Migration[7.0]
  def change
    create_table :log_activities do |t|
      t.references :activity
      t.string :event
      t.json :modifications, null: false

      t.timestamps
    end
  end
end
