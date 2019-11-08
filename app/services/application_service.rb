class ApplicationService
  # 全てのServiceクラスはこのクラスを継承する
  # 継承元のクラスはinitialize, performを実装する

  # call失敗時に呼び出されるエラークラス
  # Handlerはこのエラーをキャッチしてrollbackメソッドを実行する
  class ServiceError < StandardError; end

  # サービスを利用するクラスが呼び出すメソッド
  def call
    raise ServiceError unless perform
  end

  private

  # 実際の処理を記述するメソッド
  # 継承元のクラスはこのメソッドをオーバーライドする
  def perform
    raise NotImplementedError, "You must implement #{self.class}##{__method__}"
  end
end
