module ArticlesHelper
  def set_thumbnail(article, contents: 'article')
    class_name = 'card-image-top mx-auto w-100'
    case contents
    when 'card' then class_name = 'card-image-top mx-auto w-100'
    else class_name = 'mx-auto w-100'
    end

    if article.thumbnail.attached?
      image_tag article.thumbnail, class: class_name
    else
      image_pack_tag 'article_default.png', class: class_name
    end
  end
end
