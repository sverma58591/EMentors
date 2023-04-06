class Topic < ApplicationRecord
  belongs_to :course
  before_destroy :ensure_subscribed?

  private
  def ensure_subscribed?
    if course.purchases.count > 0
      errors.add(:course_id, "Course is purchased, can't perform the action!")
      throw(:abort)
    end
  end
end
