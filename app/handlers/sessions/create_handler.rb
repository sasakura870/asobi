module Sessions
  class CreateHandler < ApplicationHandler
    def initialize(email:, password:, remember_check:, session:, cookies:)
      @email = email
      @password = password
      @remember_check = (remember_check == '1')
      @session = session
      @cookies = cookies
    end

    private

    attr_reader :email, :password, :remember_check, :session, :cookies

    def handle
      AuthenticateService.new(user: user, password: password).call
      LoginService.new(user: user, session: session).call
      RememberService.new(user: user, cookies: cookies).call if remember_check
    end

    def user
      @user ||= User.find_by! email: email
    end
  end
end
