module Student
    class PaymentsController < ::ApplicationController
        before_action :set_course_and_user_for_payment
        def payment_successful
            # byebug
            # Stripe.api_key = 'sk_test_51MrcJdSAKcsNysZVeB965HkUl7csitC4W8vr0SmLccl3BBxHitN9VZTB59ddmek9DulvHgGpBwUr25lhGh67JvXv00O3Iqn8AQ'

            # @order = Stripe::Checkout::Session.retrieve(
            # # 'cs_test_a1fefTeacaWJo9dG9dx3BR52OqBmhWBaUXgKzToVdKnFsYRPns4VZRmLGC',
            #     @session.id,
            # )
            if @payment.save
                @payment.complete!
                if @payment.status == 'success'
                    @purchase = Purchase.new(purchase_params)
                    if @purchase.save
                        PaymentNotificationMailer.create_notification_for_student(@purchase).deliver_now
                        PaymentNotificationMailer.create_notification_for_teacher(@purchase).deliver_now
                    end
                end
            end
        end
    
        def payment_cancel
            if @payment.save
                @payment.cancel!
            end
        end
    
        private
        def payment_params
            params.require(:payment).permit(:user_id, :course_id, :payment_date)
        end
    
        def purchase_params
            params.permit(:course_id, :user_id)
        end
    
        def set_course_and_user_for_payment
            @course = Course.find(params[:course_id])
            @payment = @course.payments.new 
            @payment.user_id = params[:user_id]
        end
    end
end