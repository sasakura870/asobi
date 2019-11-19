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
    @favorites ||= user.favorite_articles.pluck :id
    logged_in? && @favorites.include?(article.id)
  end

  def follow?(target_user)
    @followings ||= user.followings.pluck :id
    logged_in? && @followings.include?(target_user.id)
  end

  def follow_tag?(tag)
    @tags ||= user.tags.pluck :id
    logged_in? && @tags.include?(tag.id)
  end

  def my_article?(article)
    @articles ||= user.articles.pluck :id
    logged_in? && @articles.include?(article.id)
  end

  private

  # SQLがView内で複数回らないようにidを格納した配列を保持しておく
  # 今後Ajaxの処理が多くなってくるともしかしたらバグるかも
  attr_reader :user, :articles, :tags, :favorites, :followings
end
