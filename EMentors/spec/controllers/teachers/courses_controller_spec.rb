require 'rails_helper'

RSpec.describe Teacher::CoursesController, type: :controller do
    let(:user) { create(:user, :teacher) }
    
    before do
        user.confirm
        sign_in user
    end

    let(:course) { create(:course, user: user) }
    
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
        context "with valid parameters" do
            let(:valid_params) do
                { course: { course_name: "Updated Course", course_description: "This is an updated course.", course_duration: 10, course_price: 200 } }
            end
        end
    end
end