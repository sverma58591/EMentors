class PaymentNotificationMailer < ApplicationMailer

  def create_notification_for_student(purchase)
    @purchase_course_id = purchase.course_id
    @course = Course.find_by(id: @purchase_course_id)
    @course_name = @course.course_name
    @student = User.find_by(id: purchase.user_id)
    @student_email = @student.email
    
    mail to: @student_email, subject: "You have purchased the #{@course_name} course"
  end
  
  def create_notification_for_teacher(purchase)
    @purchase_course_id = purchase.course_id
    @course = Course.find_by(id: @purchase_course_id)
    @teacher = User.find_by(id: @course.user_id)
    @teacher_email = @teacher.email
    @course_name = @course.course_name
    
    mail to: @teacher_email, subject: "You got a subscriber"
  end
  
end
