# class PaymentsController < ApplicationController
#     before_action :authenticate_user!
#     def new
#       @course = Course.find(params[:course_id])
#       @payment = current_user.payments.new(payment_params)
#     end

#     def create
#       @course = Course.find(params[:course_id])
#       @payment = current_user.payments.build(payment_params)
  
#       if @payment.valid?
#         customer = Stripe::Customer.create(
#           email: current_user.email,
#           source: params[:stripeToken]
#         )
  
#         charge = Stripe::PaymentIntent.create(
#           customer: customer.id,
#           amount: @course.course_price.to_f ,
#           description: @course.course_name,
#           currency: 'usd'
#         )
        
#         @payment.user_id = current_user.id
#         @payment.course_id = @course.id
#         @payment.stripe_charge_id = charge.id
#         @payment.save
  
#         @course.purchases.create(user_id: current_user.id)
#         redirect_to course_path(@course), notice: "Payment was successfully made."
#       else
#         redirect_to course_path(@course), alert: "Payment could not be processed."
#       end
#     rescue Stripe::CardError => e
#       flash[:error] = e.message
#       redirect_to course_path(@course), alert: "Payment could not be processed."
#     end
  
#     private
#     def payment_params
#       params.require(:payment).permit(:amount, :stripeToken, :course_id)
#     end
#   end