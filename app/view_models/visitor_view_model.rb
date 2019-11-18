class VisitorViewModel
  delegate :id, :name, :email, :nick_name, :introduction, :photo, :to_param,
           to: :user,
           allow_nil: true

  def initialize(user:)
    @user = user
  end

  def logged_in?
    user.present? && !user.destroyed?
  end

  def myself?(target_user)
    user == target_user
  end

  def register?
    logged_in? && user.register?
  end

  def temporary?
    logged_in? && user.temporary?
  end

  def favorite?(article)
    logged_in? && user.favorite_articles.exists?(article.id)
  end

  def follow?(target_user)
    logged_in? && user.followings.exists?(target_user.id)
  end

  def follow_tag?(tag)
    logged_in? && user.tags.exists?(tag.id)
  end

  def my_article?(article)
    logged_in? && user.articles.exists?(article.id)
  end

  private

  attr_reader :user
end
