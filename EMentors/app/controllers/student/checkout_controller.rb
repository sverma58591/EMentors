module Student
    class CheckoutController < BaseController
        def create
            @course = Course.find(params[:id])
            @session = Stripe::Checkout::Session.create({
                payment_method_types: ['card'],
                line_items: [{
                    price_data: {currency: 'usd', product_data: {name: @course.course_name}, unit_amount: @course.course_price},
                    quantity: 1,
                } ],
                mode: 'payment',
                success_url: payment_payment_successful_url(course_id: @course),
                cancel_url: payment_payment_cancel_url(course_id: @course)
              })
            respond_to do |format|
                format.js
            end
        end
    end    
end    