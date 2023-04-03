class CheckoutController < ApplicationController
    def create
        # byebug
        course = Course.find(params[:id])
        # byebug
        @session = Stripe::Checkout::Session.create({
            payment_method_types: ['card'],
            line_items: [{
                price_data: {currency: 'usd', product_data: {name: course.course_name}, unit_amount: course.course_price},
                quantity: 1,
            } ],
            mode: 'payment',
            success_url: root_url,
            cancel_url: root_url,
          })
        respond_to do |format|
            format.js
        end
    end

    def thanks
    end
end
