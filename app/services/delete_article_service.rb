class DeleteArticleService < ApplicationService
  def initialize(user:, article:)
    @user = user
    @article = article
  end

  private

  attr_reader :user, :article

  def perform
    unless article&.destroy
      service_failed message: '記事の削除に失敗しました', model: article
    end
  end
end
