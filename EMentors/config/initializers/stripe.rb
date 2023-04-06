Rails.configuration.stripe = {
  :publishable_key => ENV['PUBLISHABLE_KEY'],
  :secret_key      => ENV['SECRET_KEY'],
  :webhook_key     => ENV['WEBHOOK_KEY']
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]