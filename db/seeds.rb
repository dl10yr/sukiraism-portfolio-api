# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

(2..100).each do |i|
  User.create!(nickname: "test#{i}",name: "test#{i}",email: "test#{i}@example.com",password: "password", password_confirmation: "password")
end

(1..100).each do |i|
  Post.create!(user_id: 1, content: "testtesttest#{i}")
end

(1..10).each do |i|
  (1..10).each do |m|
    if i < 5 then
      Like.create!(user_id: i, post_id: m, suki: 1)
    else
      Like.create!(user_id: i, post_id: m, suki: 0)
    end
  end
end
