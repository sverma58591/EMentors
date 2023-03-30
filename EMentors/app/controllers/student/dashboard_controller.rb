module Student
    class DashboardController < BaseController
        def index
            @courses = Course.where.not(id: current_user.purchases.pluck(:course_id))
        end

        def show
            @course = Course.find(params[:id])
        end
    end
end