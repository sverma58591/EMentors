class Course < ApplicationRecord
  belongs_to :user
  has_many :purchases, dependent: :destroy
  has_many :topics, dependent: :destroy
  # validates :users
  # validates :course_name, presence: true, uniqueness: true
  # validates :course_duration, :course_price, presence: true
  before_validation :ensure_teacher?
  # before_destroy :
  private
  def ensure_teacher?
    unless user.teacher?
      errors.add(:user_id, "Must be a teacher to create a course")
    end
  end
end
