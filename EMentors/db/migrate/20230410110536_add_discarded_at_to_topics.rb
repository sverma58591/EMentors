class AddDiscardedAtToTopics < ActiveRecord::Migration[6.1]
  def change
    add_column :topics, :discarded_at, :datetime
    add_index :topics, :discarded_at
  end
end
