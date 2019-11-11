class RelationshipsController < ApplicationController
  before_action :filter_only_register

  def create
    # TODO service
    user = User.find_by(id: params[:user_id])
    relationship = current_user.active_relationships.build(follower_id: user.id)
    if relationship.save
      head :created
    else
      request_422
    end
  end

  def destroy
    # TODO service
    relation = current_user.active_relationships.find_by(follower_id: params[:user_id])
    if relation&.destroy
      head :ok
    else
      request_422
    end
  end
end
