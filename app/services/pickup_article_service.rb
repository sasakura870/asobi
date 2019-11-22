class PickupArticleService < ApplicationService
  def initialize; end

  private

  def perform
    pickup_id = Article.pluck(:id).sample
    service_succeeded model: Article.find(pickup_id)
  end
end
