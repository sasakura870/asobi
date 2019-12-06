class LoginService < ApplicationService
  def initialize(user:, session:)
    @user = user
    @session = session
  end

  private

  attr_reader :user, :session

  def perform
    session[:user_id] = user.id
  end
end
