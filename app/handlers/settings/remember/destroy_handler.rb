module Settings
  module Remember
    class DestroyHandler < ApplicationHandler
      def initialize(user:, cookies:)
        @user = user
        @cookies = cookies
      end

      private

      attr_reader :user, :cookies

      def handle
        ForgetService.new(user: user, cookies: cookies).call
      end
    end
  end
end
