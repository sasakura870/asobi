module GuestLogins
  class CreateHandler < ApplicationHandler
    def initialize(session:)
      @session = session
    end

    private

    attr_reader :session

    def handle
      LoginService.new(
        user: User.guest.first,
        session: session
      ).call
    end
  end
end