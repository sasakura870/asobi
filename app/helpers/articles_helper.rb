module ArticlesHelper
  def set_thumbnail(article, class_name: 'article')
    if article.thumbnail.attached?
      image_tag article.thumbnail, class: class_name
    else
      image_pack_tag 'article_default.png', class: class_name
    end
  end

  def set_user_link(user, size: 25, class_name: '')
    link_to user_path(user), class: class_name do
      user_photo(user, size: size, class_name: 'mr-2') +
        content_tag(:span, "@#{user.name}")
    end
  end
end
