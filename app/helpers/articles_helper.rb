module ArticlesHelper
  def set_thumbnail(article, class_name: nil)
    if article.content.body.attachables.blank?
      image_pack_tag 'default_article_thumbnail.png', class: class_name
    else
      image_tag article.content.body.attachables[0], class: class_name
    end
  end

  def thumbnail_url(article)
    if article.content.body.attachables.blank?
      asset_pack_path 'media/images/default_article_thumbnail.png'
    else
      url_for article.content.body.attachables[0]
    end
  end

  def tag_formatting(tag_list)
    tag_list.pluck(:name).join(',')
  end
end
