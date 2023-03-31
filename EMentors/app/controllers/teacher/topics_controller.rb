module Teacher
    class TopicsController < BaseController
        def new
            @course = Course.find(params[:course_id])
            @topic = @course.topics.new
        end
        
        def create
            # byebug
            @course = Course.find(params[:course_id])
            @topic = @course.topics.new(topics_params)

            if @topic.save
                redirect_to course_path(@course)
            else 
                render :new
            end
        end

        def edit
            @course = Course.find(params[:course_id])
            # @topic = @course.topics.update(topics_params)
            @topic = @course.topics.find(params[:id])
        end

        def update
            @course = Course.find(params[:course_id])
            @topic = @course.topics.find(params[:id])

            if @topic.update(topics_params)
                redirect_to course_path(@course)
            else 
                render :edit
            end
        end

        def destroy
            @course = Course.find(params[:course_id])
            @topic = @course.topics.find(params[:id])

            @topic.destroy
            redirect_to course_path(@course)
        end
        private
        def topics_params
            params.require(:topic).permit(:topic_name, :topic_description)
        end
    end
end
