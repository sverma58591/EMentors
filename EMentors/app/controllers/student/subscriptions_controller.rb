module Student
    class SubscriptionsController < BaseController
        def index
            @courses = Course.where(id: current_user.purchases.pluck(:course_id))
        end

        def show 
            @course = Course.find(params[:id])
        end
    end
end