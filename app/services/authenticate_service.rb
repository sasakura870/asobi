class AuthenticateService < ApplicationService
  def initialize(user:, password:)
    @user = user
    @password = password
  end

  private

  attr_reader :user, :password

  def perform
    unless user&.authenticate password
      service_failed message: 'パスワードが違います'
    end
  end
end
