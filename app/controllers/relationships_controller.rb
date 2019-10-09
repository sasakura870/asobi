class RelationshipsController < ApplicationController
  before_action :filter_only_register

  def create
    user = User.find_by(id: params[:user_id])
    relationship = current_user.active_relationships.build(follower_id: user.id)
    if relationship.save
      # flash[:success] = 'フォローしました'
      # redirect_to user
      head :created
    else
      request_422
    end
  end

  def destroy
    relation = current_user.active_relationships.find_by(follower_id: params[:user_id])
    if relation&.destroy
      # flash[:success] = 'フォローを解除しました'
      # redirect_to root_path
      head :ok
    else
      request_422
    end
  end
end
