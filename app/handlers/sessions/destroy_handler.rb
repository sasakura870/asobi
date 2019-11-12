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
      LogoutService.new(session: session).call
    end
  end
end