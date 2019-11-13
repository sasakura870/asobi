class LogoutService < ApplicationService
  def initialize(session:)
    @session = session
  end

  private

  attr_reader :session

  def perform
    session[:user_id] = nil
    service_succeeded message: 'ログアウトしました'
  end
end
