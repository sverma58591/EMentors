require 'rails_helper'

RSpec.describe Teacher::TopicsController, type: :controller do
    let(:user) { create(:user, :teacher) }
    
    before do
        user.confirm
        sign_in user
    end
    
    let(:course) { create(:course, user: user) }
    let(:topic) { create(:topic, course: course) }

    describe "GET #new" do
        it "renders the new template" do
          get :new, params: {course_id: course.id}
          expect(response).to render_template(:new)
        end
    end

    describe "POST #create" do
        it "creates a new topic" do  
            expect {
                post :create, params: { course_id: course.id, topic: {topic_name: 'Hello Topic', topic_description: 'Hello Description', post_video: Rack::Test::UploadedFile.new(Rails.root.join('spec', 'support', 'videoplayback.mp4'), 'video/mp4') }}
            }.to change(Topic, :count).by(1)
            expect(response).to redirect_to(course_path(Course.last))
        end
    end 

    describe "GET #edit" do
        it "renders the new template" do
          get :edit, params: {course_id: course.id, id: topic.id}
          expect(response).to render_template(:edit)
        end
    end

    describe "PATCH #update" do
        it "Edit an existing topic" do  
            patch :update, params: { course_id: course.id, id: topic.id, topic: {topic_name: 'Hello topic updated'}}

            expect(assigns(:topic).topic_name).to eq('Hello topic updated')
            expect(response).to redirect_to(course_path(Course.last))
        end
    end
    
    describe "DESTROY #destroy" do
        it "delete existing topic" do 
            delete :destroy, params:{ course_id: course.id, id: topic.id }
            expect(response).to redirect_to(course_path(Course.last))
            expect(Topic.discarded.count).to eq(1)
        end
    end
end