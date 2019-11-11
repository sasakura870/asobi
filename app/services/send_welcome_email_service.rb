class SendWelcomeEmailService < ApplicationService
  def initialize(user:)
    @user = user
  end

  private

  attr_reader :user

  def perform
    user.deactivate
    UserMailer.account_activation(user).deliver_now
  end
end
