module Settings
  module Profile
    class UpdateHandler < ApplicationHandler
      def initialize(user:, params:)
        @user = user
        @params = params
      end

      private

      attr_reader :user, :params

      def handle
        UpdateUserService.new(user: user, params: params).call
      end
    end
  end
end
