class TagMapsController < ApplicationController
  before_action :pass_only_allowed

  def create
    handler = TagMaps::CreateHandler.new(
      user: current_user,
      tag_id: params[:tag_id]
    ).run
    if handler.result
      render status: :ok, json: { type: 'success', message: 'フォローしました!' }
    else
      render status: :internal_server_error,
             json: { type: 'error', message: 'フォローに失敗しました' }
    end
  end

  def destroy
    handler = TagMaps::DestroyHandler.new(
      user: current_user,
      tag_id: params[:tag_id]
    ).run
    if handler.result
      render status: :ok, json: { type: 'success', message: 'フォローを解除しました' }
    else
      render status: :internal_server_error,
             json: { type: 'error', message: 'フォローの解除に失敗しました' }
    end
  end
end
