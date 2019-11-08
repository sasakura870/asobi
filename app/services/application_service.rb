class ApplicationService
  class ServiceError < StandardError; end
  # サービスを利用するクラスが呼び出すメソッド
  def call
    raise ServiceError unless perform
  end

  private

  def perform
    raise NotImplementedError, "You must implement #{self.class}##{__method__}"
  end
end
