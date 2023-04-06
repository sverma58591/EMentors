module Student
    class SubscriptionsController < BaseController
        before_action :check_subscriber?, only: [:show]
        def index
            @courses = Course.where(id: current_user.purchases.pluck(:course_id))
        end

        def show;end

        private
        def check_subscriber?
            @course = Course.find_by(id: params[:id])
            
            if @course.present? && @course.purchases.pluck(:user_id).include?(current_user.id)
                @course
            else 
                redirect_to (request.env["HTTP_REFERER"] || subscriptions_path), alert:"You are unauthorised for this!"
            end 
        end
    end
end