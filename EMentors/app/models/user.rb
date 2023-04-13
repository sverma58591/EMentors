class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :courses, dependent: :destroy
  has_many :purchases, dependent: :destroy
  has_many :payments
  validates :first_name, :role, presence: true
  enum role: {student: 0, teacher: 1}
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  def is_student?
    role === 'student'
  end
  
  def is_teacher?
    role === 'teacher'
  end
  
  def self.teachers
    where(role: :teacher)
  end
  
  def self.students
    where(role: :student)
  end
end

# scope :teacher, -> { where(role: 1) }