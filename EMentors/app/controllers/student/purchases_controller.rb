module Student
    class PurchasesController < BaseController
        before_action :check_purchase!, only: [:create]

        def create
            # byebug
            @purchase = current_user.purchases.new(purchase_params)
            if @purchase.save
                redirect_to request.env["HTTP_REFERER"], notice: "Course added to Subscribed"
            else 
                redirect_to request.env["HTTP_REFERER"], alert: "Error adding course"
            end
        end
        
        private
        def purchase_params
            params.permit(:course_id)
        end
        
        def check_purchase!
            if current_user.purchases.where(course_id: params[:course_id]).present?
                return redirect_to request.env["HTTP_REFERER"], notice: "Course is already purchased!"
            end
        end
    end
end
# render notice: "Course has already purchased!" 