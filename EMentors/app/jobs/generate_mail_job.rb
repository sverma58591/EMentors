class GenerateMailJob < ApplicationJob
  queue_as :default

  def perform(purchase)
    # Do something later
    PaymentNotificationMailer.create_notification_for_student(purchase).deliver
    PaymentNotificationMailer.create_notification_for_teacher(purchase).deliver
  end
end
