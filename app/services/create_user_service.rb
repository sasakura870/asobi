class CreateUserService < ApplicationService
  def initialize(params:, accept:)
    @params = params
    @accept = accept
  end

  private

  attr_reader :params, :accept

  def perform
    user = User.new(params)
    if accept
      service_failed message: '登録に失敗しました', model: user unless user.save
    else
      service_failed message: '利用規約への同意が必須です', model: user
    end
  end
end
