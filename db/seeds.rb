# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(name: 'naoyachan',
             nick_name: 'なおや@開発',
             email: 'a_20100409@yahoo.co.jp',
             introduction: "開発用ユーザーです。\nテスト",
             password: 'hogehoge',
             password_confirmation: 'hogehoge',
             activated: true)

99.times do |n|
  User.create!(name: "Faker_#{n}",
               email: Faker::Internet.email,
               introduction: Faker::Lorem.sentence(word_count: 5),
               password: 'password',
               password_confirmation: 'password',
               activated: true)
end

users = User.order(:created_at).take(10)
main_user = User.first
5.times do |n|
  users.each do |user|
    article = user.articles.create!(title: "#{user.name}-#{n}",
                                    overview: Faker::Lorem.sentence,
                                    content: Faker::Lorem.sentence(word_count: 10),
                                    posted: true)
    next if user == main_user

    main_user.favorites.create!(article_id: article.id) if n > 2
    if n == 0 || n == 4
      main_user.comments.create!(article_id: article.id,
                                 content: Faker::Lorem.sentence(word_count: 5))
    end
  end
end
