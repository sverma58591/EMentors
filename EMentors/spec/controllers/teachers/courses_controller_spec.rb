require 'rails_helper'

RSpec.describe Teacher::CoursesController, type: :controller do
    let(:user) { create(:user, :teacher) }
    let(:course) { create(:course) }
    
    before do
        user.confirm
        sign_in user
    end
    
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
            expect(assigns(:course)).to eq(@course)
        end
        
        it {debugger}
        it "renders the show template" do
            get :show, params: { id: course.id }
            expect(response).to render_template(:show)
        end
    end
end