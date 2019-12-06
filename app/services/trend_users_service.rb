class TrendUsersService < ApplicationService
  def initialize; end

  private

  def perform
    users = User
            .includes(photo_attachment: :blob)
            .register
            .order(id: :desc)
            .take(6)
    service_succeeded model: users
  end
end
