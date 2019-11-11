module Users
  class CreateHandler < ApplicationHandler
    def initialize(params:, accept:, session:)
      @params = params
      @accept = (accept == '1')
      @session = session
    end

    private

    attr_reader :params, :accept, :session

    def handle
      CreateUserService.new(params: params, accept: accept).call
      SendWelcomeEmailService.new(user: user).call
      LoginService.new(user: user, session: session).call
    end

    def rollback
      user.destroy if user&.id.present?
    end

    def user
      @user ||= User.find_by(email: params[:email])
    end
  end
end
