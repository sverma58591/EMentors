module Student
    class BaseController < ::ApplicationController
        before_action :authenticate_user!, :is_student?
    end
end

