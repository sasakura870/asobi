class ListupTagService < ApplicationService
  def initialize(tag_names:)
    @tag_names = tag_names
  end

  private

  attr_reader :tag_names

  def perform
    tag_array = tag_names.split.uniq
    tag_list = []
    tag_array.each do |tag_name|
      tag_list << Tag.find_or_create_by(name: tag_name)
    end
    service_succeeded model: tag_list
  end
end
