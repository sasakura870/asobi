class RelationshipsController < ApplicationController
  before_action :filter_only_register

  def create
    handler = Relationships::CreateHandler.new(
      following: current_user,
      follower_id: params[:user_id]
    ).run
    if handler.result
      head :created
    else
      request_422
    end
  end

  def destroy
    handler = Relationships::DestroyHandler.new(
      following: current_user,
      follower_id: params[:user_id]
    ).run
    if handler.result
      head :ok
    else
      request_422
    end
  end
end
