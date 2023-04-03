class Payment < ApplicationRecord
  include AASM
  
 belongs_to :user
 belongs_to :course
  
 validates :amount, presence: true
 validates :status, inclusion: { in: %w[pending cancelled success failed] }
  
 aasm column: :status, whiny_transitions: false do
   state :pending, initial: true
   state :cancelled, :success, :failed
  
   event :cancel do
     transitions from: :pending, to: :cancelled
   end
  
   event :complete do
     transitions from: :pending, to: :success
   end
  
   event :fail do
     transitions from: :pending, to: :failed
   end
  end
#  def process_payment(token)
#    Stripe.api_key = Rails.application.credentials.stripe[:secret_key]
  
#    begin
#      charge = Stripe::Charge.create(
#        amount: self.amount * 100, # Stripe expects the amount in cents
#        currency: "usd",
#        source: token,
#        description: "Payment for #{self.course.course_name}",
#        metadata: {
#          user_id: self.user.id,
#          course_id: self.course.id,
#          payment_id: self.id
#        }
#      )
  
#      self.update(payment_id: charge.id)
#      self.complete!
#    rescue Stripe::CardError => e
#      self.update(error_message: e.message)
#      self.fail!
#    end
#  end
#   end
  
end
