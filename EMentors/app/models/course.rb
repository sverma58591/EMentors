class Course < ApplicationRecord
  before_validation :ensure_teacher?
  belongs_to :user
  has_many :purchases, dependent: :destroy
  has_many :topics, dependent: :destroy
  has_many :payments
  validates :course_name, presence: true, uniqueness: true
  validates :course_duration, :course_price, presence: true
  
  private
  def ensure_teacher?
    errors.add(:user_id, "Must be a teacher to create a course") unless user.teacher?
  end 
end
