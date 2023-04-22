class Topic < ApplicationRecord
  include Discard::Model
  belongs_to :course
  before_destroy :ensure_subscribed?
  has_one_attached :post_video
  validates :topic_name, :topic_description, presence: true
  validates :post_video,  presence: true
  
  private
  
  def ensure_subscribed?
    if course.purchases.count > 0
      errors.add(:course_id, "Course is purchased, can't perform the action!") and throw(:abort)
    end
  end
end
