FactoryBot.define do
    factory :purchase do
        user { create(:user, role: :student) }
        course {create(:course)}
    end
end