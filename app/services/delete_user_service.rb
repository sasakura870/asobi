class DeleteUserService < ApplicationService
  def initialize(user:)
    @user = user
  end

  private

  attr_reader :user

  def perform
    unless user&.destroy
      service_failed message: '退会に失敗しました。時間を空けてもう一度お試しください', model: user
    end
  end
end
