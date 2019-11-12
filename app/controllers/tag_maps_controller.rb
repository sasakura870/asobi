class TagMapsController < ApplicationController
  before_action :filter_only_register

  def create
    handler = TagMaps::CreateHandler.new(
      user: current_user,
      tag_id: params[:tag_id]
    )
    if handler.run
      head :created
    else
      request_422
    end
  end

  def destroy
    handler = TagMaps::DestroyHandler.new(
      user: current_user,
      tag_id: params[:tag_id]
    )
    if handler.run
      head :ok
    else
      request_422
    end
  end
end
