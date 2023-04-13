module Teacher
    class TopicsController < BaseController
        before_action :set_course, only: %i[new create edit update destroy]
        def new
            @topic = @course.topics.new
        end
        
        def create
            @topic = @course.topics.new(topics_params)
            if @topic.save
                redirect_to course_path(@course)
            else 
                render :new
            end
        end

        def edit
            # byebug
            @topic = @course.topics.find(params[:id])
        end

        def update
            @topic = @course.topics.find(params[:id])
            if @topic.update(topics_params)
                redirect_to course_path(@course)
            else 
                render :edit
            end
        end

        def destroy
            # byebug
            @topic = @course.topics.find(params[:id])
            if @topic.discard
                respond_to do |format|
                    format.html { redirect_to course_path(@course) }
                    format.json { render :json => {:message => "success", :body => @topic} }
                end
            else
                respond_to do |format|
                    format.html { redirect_to request.env["HTTP_REFERER"], notice: "Cannot perform action!"  }
                    format.json { render :json => {:message => "false"} }
                end 
            end
        end
        
        private
        def topics_params
            params.require(:topic).permit(:topic_name, :topic_description, :post_video)
        end
        
        def set_course
            @course = Course.find(params[:course_id])
        end
    end
end
