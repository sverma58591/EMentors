module Student
    class CheckoutController < ::ApplicationController
        before_action :set_course_and_user_for_payment, only: [:create]
        before_action :set_payment, only: %i[success cancel]
        
        def create
            @session = CheckoutCreator.new(current_user, @course, checkout_success_url, checkout_cancel_url, @payment).call

            respond_to do |format|
                format.js
            end
        end

        def success
            session_id = params[:session_id]
            expand = ["line_items"]
            session_with_expand = CheckoutRetrieve.new(session_id, expand, @payment).call
            @course_name = session_with_expand.line_items.data[0].description
            @course = Course.find_by(course_name: @course_name)
        end
        
        def cancel
            @payment.cancel!
        end

        private

        def set_course_and_user_for_payment
            @course = Course.find(params[:id])
            @payment = @course.payments.new(user_id: current_user.id) 
            @payment.save
        end

        def set_payment
            @payment = Payment.find_by(id: params[:payment_id])
        end
    end    
end    
