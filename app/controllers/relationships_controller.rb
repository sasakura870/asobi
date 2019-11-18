class RelationshipsController < ApplicationController
  before_action :filter_only_register

  def create
    handler = Relationships::CreateHandler.new(
      following: current_user,
      follower_id: params[:user_id]
    ).run
    if handler.result
      render status: :ok, json: { type: 'success', message: 'フォローしました!' }
    else
      render status: :internal_server_error,
             json: { type: 'error', message: 'フォローに失敗しました' }
    end
  end

  def destroy
    handler = Relationships::DestroyHandler.new(
      following: current_user,
      follower_id: params[:user_id]
    ).run
    if handler.result
      render status: :ok, json: { type: 'success', message: 'フォローを解除しました' }
    else
      render status: :internal_server_error,
             json: { type: 'error', message: 'フォローの解除に失敗しました' }
    end
  end
end
