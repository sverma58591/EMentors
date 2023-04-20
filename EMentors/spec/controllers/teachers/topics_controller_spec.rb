require 'rails_helper'

RSpec.describe Teacher::TopicsController, type: :controller do
    let(:user) { create(:user, :teacher) }
    
    before do
        user.confirm
        sign_in user
    end
    
end