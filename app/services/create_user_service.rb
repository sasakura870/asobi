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
      if user.save
        service_succeeded model: user
      else
        service_failed message: '登録に失敗しました', model: user
      end
    else
      service_failed message: '利用規約への同意が必須です', model: user
    end
  end
end
