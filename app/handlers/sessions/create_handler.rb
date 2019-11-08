module Sessions
  class CreateHandler < ApplicationServiceHandler
    def initialize(email:, password:, remember_check:)
      @email = email
      @password = password
      @remember_check = (remember_check == '1')
    end

    private

    attr_reader :email, :password, :remember_check

    def handle
      # authenticate
      # login
      # remember
    end
  end
end
