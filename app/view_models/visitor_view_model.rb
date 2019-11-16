class VisitorViewModel
  delegate :id, to: :user, allow_nil: true

  def initialize(user:)
    @user = user
  end

  def logged_in?
    user.present?
  end

  def myself?(target_user)
    user == target_user
  end

  private

  attr_reader :user
end
