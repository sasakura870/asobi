# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user_list = []
80.times do |n|
  user_list << User.new(
    name: n.zero? ? 'naoyachan' : "Faker_#{n}",
    nick_name: n.odd? ? Faker::Name.name : '',
    email: n.zero? ? 'a_20100409@yahoo.co.jp' : "faker#{n}@example.com",
    introduction: Faker::Lorem.sentence(word_count: 5),
    password: 'hogehoge',
    password_confirmation: 'hogehoge',
    status: :register
  )
end
User.import user_list
Faker::Config.locale = :en
User.take(20).each do |user|
  user.photo.attach(
    io: OpenURI.open_uri(Faker::Avatar.image(size: '200x200', set: 'set4', bgset: 'bg1')),
    filename: 'photo.png',
    content_type: 'image/png'
  )
end
Faker::Config.locale = :ja

users = User.take(40)
dummy_content = ''
File.open('spec/actiontext/dummy_data.html', 'r') do |f|
  dummy_content = f.read
end
users.each do |user|
  5.times do |n|
    params = {
      title: "#{user.name}-#{n}",
      overview: Faker::Lorem.sentence,
      content: dummy_content,
      status: :published
    }
    tag_list = []
    5.times { tag_list << Faker::Sports::Basketball.team }
    5.times { tag_list << Faker::Games::Pokemon.name }
    Articles::CreateHandler.new(
      user: user,
      params: params,
      tag_names: tag_list.join(',')
    ).run
  end
end

favorite_list = []
comment_list = []
Article.find_each do |article|
  users.each do |user|
    check_num = article.id * user.id
    if (check_num % 7) < 4
      favorite_list << article.favorites.build(
        user_id: user.id
      )
    end
    next unless (check_num % 7) < 2 && check_num.odd?

    comment_list << article.comments.build(
      user_id: user.id,
      content: Faker::Lorem.sentence(word_count: 5)
    )
  end
end
Favorite.import favorite_list
Comment.import comment_list
