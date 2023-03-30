class Topic < ApplicationRecord
  belongs_to :course
  private
  def ensure_teacher?
    unless user.teacher?
      errors.add(:user_id, "Must be a teacher to create a topics")
    end
  end
end
