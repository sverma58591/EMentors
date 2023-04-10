class Topic < ApplicationRecord
  belongs_to :course
  before_destroy :ensure_subscribed?
  has_one_attached :post_video
  # validates :post_video,  presence: true
  private
  def ensure_subscribed?
    if course.purchases.count > 0
      errors.add(:course_id, "Course is purchased, can't perform the action!")
      throw(:abort)
    end
  end
end
