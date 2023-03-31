class ChargesController < ApplicationController
  before_action :authenticate_user!, :amount_to_be_charged, :set_description
  def new
  end

  def create
    # byebug
    customer = Stripe::Customer.create(email: params[:stripeEmail], source: params[:stripeToken])
    @user = current_user
    @course = Course.find(params[:id])
    charge = Stripe::PaymentIntent.create(
      customer: customer.id,
      amount: @amount,
      description: @description,
      currency: 'usd'
    )
    redirect_to thanks_path
    rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end

  def thanks
  end

  
  private
    def set_description
      @description = "Some amazing product"
    end

    def amount_to_be_charged
      @amount = 500
    end
end