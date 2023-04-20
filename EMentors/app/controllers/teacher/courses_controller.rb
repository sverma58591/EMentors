module Teacher 
  class CoursesController < BaseController
      before_action :check_subscribed!, only: [:destroy]
      before_action :set_course, only: %i[show edit update destroy]
      def index
        @courses = current_user.courses.kept
      end
      
      def new
        @course = current_user.courses.new
      end
    
      def show;end
    
      def create
        @course = current_user.courses.new(course_params)
    
        if @course.save
          redirect_to @course
        else 
          render :new
        end
      end
    
      def edit;end
    
      def update
        if @course.update(course_params)
          redirect_to @course
        else 
          render :edit
        end
      end
    
      def destroy
        byebug
        if @course.discard
          byebug
          redirect_to courses_path
        else
          redirect_to request.env["HTTP_REFERER"], notice: "Cannot perform action!"
        end
      end

      private

      def course_params
        params.require(:course).permit(:course_name, :course_description, :course_duration, :course_price)
      end

      def check_subscribed!
        if current_user.courses.find(params[:id]).purchases.count > 0
          return redirect_to request.env["HTTP_REFERER"], notice: "Cannot perform action!"
        end
      end

      def set_course
        debugger
        @course = current_user.courses.find(params[:id])
      end
    end
  end