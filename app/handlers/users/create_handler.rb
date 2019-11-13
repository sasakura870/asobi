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
      ActiveRecord::Base.transaction do
        params[:email] = params[:email].downcase
        mailer = UserMailer.account_activation user
        CreateUserService.new(params: params, accept: accept).call
        SendActivationEmailService.new(user: user, mailer: mailer).call
        LoginService.new(user: user, session: session).call
      end
    end

    def user
      @user ||= User.find_by(email: params[:email])
    end
  end
end
