class RememberService < ApplicationService
  def initialize(user:, cookies:)
    @user = user
    @cookies = cookies
  end

  private

  attr_reader :user, :cookies

  def perform
    expire = 1.month.from_now.utc
    user.remember_me
    cookies.signed[:user_id] = { value: user.id, expires: expire }
    cookies[:remember] = { value: user.remember, expires: expire }
  end
end
