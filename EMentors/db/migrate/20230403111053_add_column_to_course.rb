class AddColumnToCourse < ActiveRecord::Migration[6.1]
  def change
    add_column :courses, :course_price, :integer
  end
end
