require 'rails_helper'

RSpec.describe Teacher::CoursesController, type: :controller do
    let(:user) { create(:user, :teacher) }
    
    before do
        user.confirm
        sign_in user
    end

    let(:course) { create(:course, user: user) }
    let(:course2) { create(:course, user: user) }
    
    describe "GET #index" do
        it "assigns the user's courses to @courses" do
            get :index
            expect(assigns(:courses)).to eq(user.courses.kept)
        end
      
        it "renders the index template" do
            get :index
            expect(response).to render_template(:index)
        end
    end

    describe "GET #show" do
        it "assigns the requested course to @course" do
            get :show, params: { id: course.id }
            expect(assigns(:course)).to eq(course)
        end
        
        it "renders the show template" do
            get :show, params: { id: course.id }
            expect(response).to render_template(:show)
        end
    end

    describe "GET #edit" do
        it "assigns the requested course to @course" do
          get :edit, params: { id: course.id }
          expect(assigns(:course)).to eq(course)
        end
        
        it "renders the edit template" do
          get :edit, params: { id: course.id }
          expect(response).to render_template(:edit)
        end
    end
      
    describe "PATCH #update" do
        it "with valid parameters" do
            patch :update, params: { id: course.id, course: {course_name: 'updated course name' } }
            expect(assigns(:course).course_name).to eq('updated course name')
            expect(response).to redirect_to(course_path)
        end

        
    end

    describe "CREATE #create" do
        it "creates a new course" do  
            # debugger
            expect {
                post :create, params: { course: {course_name: 'updated course name', course_description: 'dasfaf', course_price: 51, course_duration: '1 month' } }
            }.to change(Course, :count).by(1)
            # expect(response).to redirect_to(course_path)
        end
    end

    describe "DELETE #destroy" do
        it "delete existing course" do 
            # delete :destroy, params:{ id: course.id }
            # expect(response).to redirect_to(courses_path)
            # expect(Course.discarded.count).to eq(1)
            expect {
                delete :destroy, params: {id: course.id}
            }.to change(Course.kept, :count).by(-1)
        end
    end
end