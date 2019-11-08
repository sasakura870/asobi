class LogoutService < ApplicationService
  def initialize(session:)
    @session = session
  end

  private

  attr_reader :session

  def perform
    session.delete :user_id
  end
end
