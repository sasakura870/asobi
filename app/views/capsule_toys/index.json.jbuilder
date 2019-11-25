json.article do |article|
  article.extract! @article, :title, :overview, :id_digest, :favorites_count, :comments_count
  article.thumbnail thumbnail_url(@article)
end
json.user do |user|
  user.extract! @user, :name, :nick_name
  user.photo user_photo_url(@user)
end
json.tags do |tags|
  tags.array! @tags, :name
end
