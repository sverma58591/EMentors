class RemoveColumnFromCourse < ActiveRecord::Migration[6.1]
  def change
    remove_column :courses, :course_price
  end
end
