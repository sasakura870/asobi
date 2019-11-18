module Settings
  module Account
    class UpdateHandler < ApplicationHandler
      def initialize(user:, email:)
        @user = user
        @email = email.downcase
      end

      private

      attr_reader :user, :email

      def handle
        update_result = UpdateUserService.new(user: user, params: { email: email }).call
        mailer = UserMailer.email_resetting update_result.model
        SendActivationEmailService.new(user: user, mailer: mailer).call
      end
    end
  end
end
