module Student
    class SubscriptionsController < BaseController
        def index
            @courses = Course.where(id: current_user.purchases.pluck(:course_id))
        end
    end
end