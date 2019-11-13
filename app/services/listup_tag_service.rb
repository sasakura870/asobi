class ListupTagService < ApplicationService
  def initialize(article:, tag_names:)
    @article = article
    @tag_names = tag_names
  end

  private

  attr_reader :article, :tag_names

  def perform
    tag_array = tag_names.split.reject(&:blank?).uniq
    tag_list = []
    tag_array.each do |tag_name|
      tag = Tag.find_or_create_by(name: tag_name)
      if tag.persisted?
        tag_list << tag
      else
        service_failed message: 'タグの文字数はひとつにつき最大140字です', model: article
        return
      end
    end
    if tag_list.size < 11
      service_succeeded model: tag_list
    else
      service_failed message: 'タグは10個まで指定できます', model: tag_list
    end
  end
end
