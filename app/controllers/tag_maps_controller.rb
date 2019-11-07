class TagMapsController < ApplicationController
  before_action :filter_only_register

  def create
    tag = Tag.find_by(id: params[:tag_id])
    tag_map = current_user.tag_maps.build(tag_id: tag.id)
    if tag_map.save
      head :created
    else
      request_422
    end
  end

  def destroy
    map = current_user.tag_maps.find_by(tag_id: params[:tag_id])
    if map&.destroy
      head :ok
    else
      request_422
    end
  end
end
