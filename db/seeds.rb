# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(name: 'naoyachan',
             email: 'a_20100409@yahoo.co.jp',
             introduction: "開発用ユーザーです。\nテスト",
             password: 'hogehoge',
             password_confirmation: 'hogehoge')

99.times do |n|
  User.create!(name: "Faker-#{n}",
               email: Faker::Internet.email,
               introduction: Faker::Lorem.sentence(5),
               password: 'password',
               password_confirmation: 'password')
end
