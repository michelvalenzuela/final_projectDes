# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
Account.delete_all
AdminUser.delete_all
Community.delete_all

AdminUser.create!(email: 'admin@admin.com', password: '123456', password_confirmation: '123456') if Rails.env.development?

Account.create!(first_name: "Example User",
                last_name: "Example Userr",
                username: "example username",
                email: "example@railstutorial.org",
                password:              "foobar",
                password_confirmation: "foobar"
               )

99.times do |n|
    first_name  = Faker::Name.first_name
    last_name = Faker::Name.last_name
    username = Faker::Name.initials
    email = "example-#{n+1}-#{n+1}@railstutorial-#{n+1}.org"
    password = "password"
    Account.create!(first_name: first_name,
                last_name: last_name,
                username: username,
                email: email,
                password:              password,
                password_confirmation: password
               )
end

users = Account.order(:created_at).take(6)

30.times do
  content = Faker::Lorem.sentence(1)
  users.each { |user| user.communities.create!(account_id: user.id,name: content,url: content,rules: content  ) }
end







