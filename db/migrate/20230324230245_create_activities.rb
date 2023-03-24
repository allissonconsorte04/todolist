class CreateActivities < ActiveRecord::Migration[7.0]
  def change
    create_table :activities do |t|
      t.string :code, null: false, unique: true, limit: 22
      t.string :title, null: false
      t.text :description
      t.references :category, null: false, foreign_key: true
      t.references :status, null: false, foreign_key: true
      t.boolean :public, default: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :activities, :code, unique: true
    add_index :activities, :title
    add_index :activities, :description
  end
end
