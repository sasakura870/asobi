module Settings
  module Remember
    class CreateHandler < ApplicationHandler
      def initialize(user:, cookies:)
        @user = user
        @cookies = cookies
      end

      private

      attr_reader :user, :cookies

      def handle
        RememberService.new(user: user, cookies: cookies).call
      end
    end
  end
end
