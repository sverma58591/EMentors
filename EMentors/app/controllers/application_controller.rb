class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    rescue_from ::ActiveRecord::RecordNotFound, with: :record_not_found
    
    protected
    def is_student?
        redirect_to (request.env["HTTP_REFERER"] || courses_path), alert:"You are unauthorised for this!" unless current_user&.is_student?
    end
    
    def is_teacher?
        redirect_to (request.env["HTTP_REFERER"] || dashboard_index_path), alert:"You are unauthorised for this!" unless current_user&.is_teacher?
    end
    
    def after_sign_in_path_for(resource)
        return courses_path if resource&.is_teacher?
        return dashboard_index_path if resource&.is_student?
    end

    def after_sign_out_path_for(resource)
        new_user_session_path
    end
    
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :role])
        devise_parameter_sanitizer.permit(:account_update, keys:[:first_name, :last_name, :role])
    end

    private
    def record_not_found
        redirect_to courses_path , alert: "Record not found!"
    end
end
