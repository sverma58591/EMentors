class CreateTopics < ActiveRecord::Migration[6.1]
  def change
    create_table :topics do |t|
      t.string :topic_name
      t.string :topic_description
      t.references :course, null: false, foreign_key: true

      t.timestamps
    end
  end
end
