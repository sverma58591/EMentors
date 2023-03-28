module Teacher 
    class CoursesController < BaseController
        def index
          @courses = current_user.courses.all
        end
        
        def new
          @course = current_user.courses.new
        end
      
        def show
          @course = current_user.courses.find(params[:id])
        end
      
        def create
          @course = current_user.courses.new(course_params)
        #   courses.user = current_user
      
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
    end
end