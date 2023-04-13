require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:role) }
  end

  describe "associations" do
    it { should have_many(:courses).dependent(:destroy) }
    it { should have_many(:purchases).dependent(:destroy) }
    it { should have_many(:payments) }
  end

  describe "enums" do
    it { should define_enum_for(:role).with_values({ student: 0, teacher: 1 }) }
  end

  describe "methods" do
    let(:user) { create(:user) }
    describe "#is_student?" do
      it "returns true if the user is a student" do
        user.role = "student"
        expect(user.is_student?).to be true
      end
      it "returns false if the user is a teacher" do
        user.role = "teacher"
        expect(user.is_student?).to be false
      end
    end

    describe "#is_teacher?" do
      it "returns true if the user is a teacher" do
        user.role = "teacher"
        expect(user.is_teacher?).to be true
      end

      it "returns false if the user is a student" do
        user.role = "student"
        expect(user.is_teacher?).to be false
      end
    end
  end
end
