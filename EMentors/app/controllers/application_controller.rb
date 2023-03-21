class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    protected
    def after_sign_in_path_for(resource)
        home_index_path
    end
    def after_sign_out_path_for(resource)
        new_user_session_path
    end
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
    end
end
