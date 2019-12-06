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
        result = CreateUserService.new(params: params, accept: accept).call
        SendActivationEmailService.new(
          user: result.model,
          mailer: UserMailer.account_activation(result.model)
        ).call
        LoginService.new(user: result.model, session: session).call
      end
    end
  end
end
