require 'rails_helper'
RSpec.describe Course, type: :model do
    subject { create(:course) }
    
    it { is_expected.to have_many(:purchases).dependent(:destroy) }
    it { is_expected.to have_many(:topics).dependent(:destroy) }
    it { is_expected.to have_many(:payments) }
    
    it { is_expected.to validate_presence_of(:course_name) }
    it { is_expected.to validate_presence_of(:course_description) }
    it { is_expected.to validate_presence_of(:course_duration) }
    it { is_expected.to validate_presence_of(:course_price) }
    it { is_expected.to validate_uniqueness_of(:course_name) }
end