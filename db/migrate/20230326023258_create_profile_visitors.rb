class CreateProfileVisitors < ActiveRecord::Migration[7.0]
  def change
    create_table :profile_visitors do |t|
      t.references :visitee, null: false, foreign_key: { to_table: :users }
      t.references :visitator, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
