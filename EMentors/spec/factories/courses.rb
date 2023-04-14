FactoryBot.define do
    factory :course do
        user { create(:user, role: 'teacher') }
        course_name { Faker::Lorem.sentence }
        course_description { Faker::Lorem.paragraph }
        course_duration { Faker::Number.between(from: 1, to: 10) }
        course_price { Faker::Number.between(from: 10, to: 100) }
    end
end