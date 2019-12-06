module Settings
  module Quit
    class DestroyHandler < ApplicationHandler
      def initialize(user:, password:, session:, cookies:)
        @user = user
        @password = password
        @session = session
        @cookies = cookies
      end

      private

      attr_reader :user, :password, :session, :cookies

      def handle
        AuthenticateService.new(user: user, password: password).call
        ForgetService.new(user: user, cookies: cookies).call
        DeleteUserService.new(user: user).call
        LogoutService.new(session: session).call
      end
    end
  end
end
