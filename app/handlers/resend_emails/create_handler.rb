module ResendEmails
  class CreateHandler < ApplicationHandler
    def initialize(user:)
      @user = user
    end

    private

    attr_reader :user

    def handle
      SendActivationEmailService.new(
        user: user,
        mailer: UserMailer.email_resetting(user)
      ).call
    end
  end
end
