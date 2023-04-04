class PaymentsController < ApplicationController
    def payment_successful
        @course = Course.find(params[:course_id])
        @payment = @course.payments.new 
        @payment.payment_date = Date.today()
        @payment.user_id = current_user.id
        @payment.save
        @payment.complete!
        if @payment.status == 'success'
            @purchase = current_user.purchases.new(purchase_params)
            @purchase.save
        end
    end

    def payment_cancel
        @course = Course.find(params[:course_id])
        @payment = @course.payments.new 
        @payment.payment_date = Date.today()
        @payment.user_id = current_user.id
        @payment.save
        @payment.cancel!
    end

    private
    def payment_params
        params.require(:payment).permit(:user_id, :course_id, :payment_date)
    end

    def purchase_params
        params.permit(:course_id)
    end
end