class SendActivationEmailService < ApplicationService
  def initialize(user:, mailer:)
    @user = user
    @mailer = mailer
  end

  private

  attr_reader :user, :mailer

  def perform
    user.deactivate
    mailer.deliver_now
  end
end
