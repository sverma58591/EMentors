module Student
    class DashboardController < BaseController
        before_action :course_id_valid?, only: [:show]
        def index
            @courses = Course.where.not(id: current_user.purchases.pluck(:course_id))
        end

        def show
        end
        
        private
        def course_id_valid?
            @course = Course.find_by(id: params[:id])
            if @course.nil?
                redirect_to (request.env["HTTP REFERER"] || dashboard_index_path), alert: "Error finding course"
            else 
                @course
            end
        end
    end
end