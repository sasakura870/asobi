class LogoutService < ApplicationService
  def initialize(session:)
    @session = session
  end

  private

  attr_reader :session

  def perform
    session[:user_id] = nil
  end
end
