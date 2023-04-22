class CreateCourses < ActiveRecord::Migration[6.1]
  def change
    create_table :courses do |t|
      t.string :course_name
      t.string :course_description
      t.string :course_duration
      t.string :course_price
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
