class Payment < ApplicationRecord
  include AASM
  belongs_to :user
  belongs_to :course
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
end