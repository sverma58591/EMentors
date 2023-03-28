module Teacher
    class BaseController < ::ApplicationController
        before_action :authenticate_user!, :is_teacher?
        layout 'teacher'
    end
end
