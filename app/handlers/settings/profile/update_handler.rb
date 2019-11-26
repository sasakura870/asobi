module Settings
  module Profile
    class UpdateHandler < ApplicationHandler
      def initialize(user:, params:, photo:)
        @user = user
        @params = params
        @photo = photo
      end

      private

      attr_reader :user, :params, :photo

      def handle
        result = UpdateUserService.new(user: user, params: params).call
        unless photo.blank?
          AttachUserPhotoService.new(
            user: result.model,
            photo: photo
          ).call
        end
      end
    end
  end
end
