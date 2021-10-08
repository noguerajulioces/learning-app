30.times do 
    Course.create!(
        title: Faker::Educator.course_name,
        description: Faker::Lorem.paragraph,
    )
end