class AddDiscardedAtToActivities < ActiveRecord::Migration[7.0]
  def change
    add_column :activities, :discarded_at, :datetime
    add_index :activities, :discarded_at
  end
end
