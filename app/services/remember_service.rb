class RememberService < ApplicationService
  def initialize(user:, cookies:)
    @user = user
    @cookies = cookies
  end

  private

  attr_reader :user, :cookies

  def perform
    expire = 1.month.from_now.utc
    current_user.remember_me
    cookies.signed[:user_id] = { value: current_user.id, expires: expire }
    cookies[:remember] = { value: current_user.remember, expires: expire }
  end
end
