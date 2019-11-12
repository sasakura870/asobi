class DeleteArticleService < ApplicationService
  def initialize(user:, article:)
    @user = user
    @article = article
  end

  private

  attr_reader :user, :article

  def perform
    service_failed message: '下書きの削除に失敗しました' unless article&.destroy
  end
end
