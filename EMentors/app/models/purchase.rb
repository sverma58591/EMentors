class Purchase < ApplicationRecord
  before_validation :ensure_student?
  validates :user_id, uniqueness: { scope: :course_id }
  belongs_to :user
  belongs_to :course

  private
  def ensure_student?
    unless user.student?
      errors.add(:user_id, "Must be a student to produce a course")
    end
  end
end
