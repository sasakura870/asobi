class ForgetService < ApplicationService
  def initialize(user:, cookies:)
    @user = user
    @cookies = cookies
  end

  private

  attr_reader :user, :cookies

  def perform
    user.forget_me
    cookies.delete :user_id
    cookies.delete :remember
  end
end
