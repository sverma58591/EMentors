# Preview all emails at http://localhost:3000/rails/mailers/payment_notification_mailer
class PaymentNotificationMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/payment_notification_mailer/create_notification
  def create_notification
    PaymentNotificationMailer.create_notification
  end

  # Preview this email at http://localhost:3000/rails/mailers/payment_notification_mailer/update_notification
  def update_notification
    PaymentNotificationMailer.update_notification
  end

  # Preview this email at http://localhost:3000/rails/mailers/payment_notification_mailer/delete_notification
  def delete_notification
    PaymentNotificationMailer.delete_notification
  end

end
