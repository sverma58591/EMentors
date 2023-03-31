module Teacher
    class SubscribersController < BaseController
        def index
            @course = current_user.courses.find(params[:course_id])
            users_id = @course.purchases.pluck(:user_id)
            @users = User.where(id: users_id)
        end
    end
end