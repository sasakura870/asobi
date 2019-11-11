class UpdateUserService < ApplicationService
  def initialize(user:, params:)
    @user = user
    @params = params
  end

  private

  attr_reader :user, :params

  def perform
    service_failed message: '更新に失敗しました', model: user unless user.update params
  end
end
