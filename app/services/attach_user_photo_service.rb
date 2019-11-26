class AttachUserPhotoService < ApplicationService
  def initialize(user:, photo:)
    @user = user
    @photo = photo
  end

  private

  attr_reader :user, :photo

  def perform
    if user.attach_base64_photo photo
      service_succeeded model: user
    else
      service_failed model: user
    end
  end
end
