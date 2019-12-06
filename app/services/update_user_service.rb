class UpdateUserService < ApplicationService
  def initialize(user:, params:)
    @user = user
    @params = params
  end

  private

  attr_reader :user, :params

  def perform
    if user.update params
      service_succeeded model: user
    else
      service_failed message: '更新に失敗しました', model: user
    end
  end
end
