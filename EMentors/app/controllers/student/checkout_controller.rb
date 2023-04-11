module Student
    class CheckoutController < ::ApplicationController
        before_action :set_course_and_user_for_payment, only: [:create]
        before_action :set_payment, only: %i[success cancel]
        def create
            # byebug
            @course = Course.find(params[:id])
            @session = Stripe::Checkout::Session.create({
                payment_method_types: ['card'],
                customer_email: current_user.email,
                line_items: [{
                    price_data: {currency: 'inr', product_data: {name: @course.course_name}, unit_amount: @course.course_price},
                    quantity: 1,
                } ],
                mode: 'payment',
                success_url: checkout_success_url + "?session_id={CHECKOUT_SESSION_ID}" + "&payment_id=" + @payment.id.to_s,
                cancel_url: checkout_cancel_url + "?session_id={CHECKOUT_SESSION_ID}" + "&payment_id=" + @payment.id.to_s
              })
              respond_to do |format|
                format.js
            end
        end

        def success
            session_with_expand = Stripe::Checkout::Session.retrieve({ id: params[:session_id], expand: ["line_items"]})
            @email = session_with_expand.customer_details.email
            @user = User.find_by(email: @email)
            @course_name = session_with_expand.line_items.data[0].description
            @course = Course.find_by(course_name: @course_name)
    

            # byebug
            if @payment.course == @course and @payment.user = @user
                @payment.complete!
                @purchase = @course.purchases.new
                @purchase.user_id = @user.id
                @purchase.save
            else
                #Refund process
            end
        end
        
        def cancel
            @payment.cancel!
        end

        private
        def set_course_and_user_for_payment
            @course = Course.find(params[:id])
            @payment = @course.payments.new 
            @payment.user_id = current_user.id
            @payment.save
        end

        def set_payment
            @payment_id = params[:payment_id]
            @payment = Payment.find_by(id: @payment_id)
        end
    end    
end    
