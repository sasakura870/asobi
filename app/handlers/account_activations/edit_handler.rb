module AccountActivations
  class EditHandler < ApplicationHandler
    def initialize(email:, activation_token:, session:)
      @email = email
      @token = activation_token
      @session = session
    end

    private

    attr_reader :email, :token, :session

    def handle
      AccountActivationService.new(user: user, token: token).call
      LoginService.new(user: user, session: session).call
    end

    def user
      @user ||= User.find_by! email: email
    end
  end
end
