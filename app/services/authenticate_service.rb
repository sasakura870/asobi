class AuthenticateService < ApplicationService
  def initialize(user:, password:)
    @user = user
    @password = password
  end

  private

  attr_reader :user, :password

  def perform
    user&.authenticate(password)
  end
end
