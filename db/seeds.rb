# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user_list = []
user_list << User.new(
  name: 'naoyachan',
  nick_name: 'なおや@開発',
  email: 'a_20100409@yahoo.co.jp',
  introduction: "開発用ユーザーです。\nテスト",
  password: 'hogehoge',
  password_confirmation: 'hogehoge',
  status: :register
)
99.times do |n|
  user_list << User.new(
    name: "Faker_#{n}",
    email: Faker::Internet.email,
    introduction: Faker::Lorem.sentence(word_count: 5),
    password: 'password',
    password_confirmation: 'password',
    status: :register
  )
end
User.import user_list

users = User.order(:created_at).take(10)
users.each do |user|
  article_list = []
  5.times do |n|
    article_list << user.articles.new(
      title: "#{user.name}-#{n}",
      overview: Faker::Lorem.sentence,
      content: Faker::Lorem.sentence(word_count: 10),
      status: :published,
      # bulk insertはafter createが実行されない
      id_digest: Digest::MD5.hexdigest(n.to_s)
    )
  end
  Article.import article_list
end

tag_list = []
20.times do |n|
  tag_list << Tag.new(name: n.to_s)
  tag_list << Tag.new(name: (100 - n).to_s)
end
Tag.import tag_list

tag_maps = []
Tag.find_each do |tag|
  Article.find_each do |article|
    tag_maps << article.tag_maps.build(tag_id: tag.id) if (article.id % tag.id).zero? && article.tags.count <= 10
  end
end
TagMap.import tag_maps
