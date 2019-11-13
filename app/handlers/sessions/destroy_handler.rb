module Sessions
  class DestroyHandler < ApplicationHandler
    def initialize(user:, session:, cookies:)
      @user = user
      @session = session
      @cookies = cookies
    end

    private

    attr_reader :user, :session, :cookies

    def handle
      ForgetService.new(user: user, cookies: cookies).call
      result = LogoutService.new(session: session).call
      handle_succeeded message: result.message
    end
  end
end
