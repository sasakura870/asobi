module Settings
  module Password
    class UpdateHandler < ApplicationHandler
      def initialize(user:, old_password:, password:, password_confirmation:)
        @user = user
        @old_password = old_password
        @password = password
        @password_confirmation = password_confirmation
      end

      private

      attr_reader :user, :old_password, :password, :password_confirmation

      def handle
        params = { password: password, password_confirmation: password_confirmation }
        AuthenticateService.new(user: user, password: old_password).call
        UpdateUserService.new(user: user, params: params).call
      end
    end
  end
end
