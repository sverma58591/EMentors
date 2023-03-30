module Teacher 
  class CoursesController < BaseController
      before_action :check_subscribers!, only: [:destroy]
      def index
        @courses = current_user.courses.all
      end
      
      def new
        @course = current_user.courses.new
      end
    
      def show
        # byebug
        @course = current_user.courses.find(params[:id])
        @users_id = @course.purchases.pluck(:user_id)
        @users = User.where(id: @users_id)
      end
    
      def create
        @course = current_user.courses.new(course_params)
    
        if @course.save
          redirect_to @course
        else 
          render :new
        end
      end
    
      def edit
        @course = current_user.courses.find(params[:id])
      end
    
      def update
        @course = current_user.courses.find(params[:id])
    
        if @course.update(course_params)
          redirect_to @course
        else 
          render :edit
        end
      end
    
      def destroy
        @course = current_user.courses.find(params[:id])
        @course.destroy
        
        redirect_to courses_path
      end
      private
      def course_params
        params.require(:course).permit(:course_name, :course_description, :course_duration, :course_price)
      end

      def check_subscribers!
        if current_user.courses.find(params[:id]).purchases.count > 0
          return redirect_to request.env["HTTP_REFERER"], notice: "Cannot perform action!"
        end
      end
    end
  end