class DeleteArticleService < ApplicationService
  def initialize(user:, article:)
    @user = user
    @article = article
  end

  private

  attr_reader :user, :article

  def perform
    service_failed message: '記事の削除に失敗しました', model: article unless article&.destroy
  end
end
