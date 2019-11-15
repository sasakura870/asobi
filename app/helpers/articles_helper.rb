module ArticlesHelper
  def set_thumbnail(article, class_name: 'article')
    # if article.thumbnail.attached?
    #   image_tag article.thumbnail, class: class_name
    # else
    #   image_pack_tag 'article_default.png', class: class_name
    # end
    image_pack_tag 'article_default.png', class: class_name
  end

  def tag_formatting(tag_list)
    tag_list.pluck(:name).join(',')
  end
end
