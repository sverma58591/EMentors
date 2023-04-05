class PaymentsController < ApplicationController
    def payment_successful
        @course = Course.find(params[:course_id])
        @payment = @course.payments.new 
        @payment.payment_date = Date.today()
        @payment.user_id = current_user.id
        if @payment.save
            @payment.complete!
            if @payment.status == 'success'
                @purchase = current_user.purchases.new(purchase_params)
                if @purchase.save
                    PaymentNotificationMailer.create_notification_for_student(@purchase).deliver_now
                    PaymentNotificationMailer.create_notification_for_teacher(@purchase).deliver_now
                end
            end
        end
    end

    def payment_cancel
        @course = Course.find(params[:course_id])
        @payment = @course.payments.new 
        @payment.payment_date = Date.today()
        @payment.user_id = current_user.id
        if @payment.save
            @payment.cancel!
        end
    end

    private
    def payment_params
        params.require(:payment).permit(:user_id, :course_id, :payment_date)
    end

    def purchase_params
        params.permit(:course_id)
    end
end