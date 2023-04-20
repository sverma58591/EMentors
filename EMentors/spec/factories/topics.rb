FactoryBot.define do
    factory :topic do
        course {create(:course)}
        topic_name { Faker::Lorem.sentence }
        topic_description { Faker::Lorem.paragraph }
        post_video { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'support', 'videoplayback.mp4'), 'video/mp4') }
    end
end