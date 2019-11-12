class AccountActivationService < ApplicationService
  def initialize(user:, token:)
    @user = user
    @token = token
  end

  private

  attr_reader :user, :token

  def perform
    if user&.authenticate_activation token && user&.temporary? && !user&.activation_mail_expired?
      user.signup
    else
      service_failed message: '無効なURLです'
    end
  end
end
