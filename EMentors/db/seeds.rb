# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# teachers = User.teachers
# teachers.each do |teacher|
#     puts teacher
#     5.times do |i|
#         teacher.courses.create(
#             course_name: "Course #{i + 5}",
#             course_description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
#             course_duration: "#{i + 1} months",
#             course_price: "200/-"
#         )
#     end
# end

# courses = Course.all
# courses.each do |course|
#     5.times do |i|
#         course.topics.create(
#             topic_name: "Topic Name #{i + 1}",
#             topic_description: "Topic Description #{i + 1}"
#         )
#     end
# end

# @courses = Course.all
# @courses.each do |course|
#     course.course_price = 200
# end