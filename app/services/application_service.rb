class ApplicationService
  # 全てのServiceクラスはこのクラスを継承する
  # 継承元のクラスはinitialize, performを実装する

  # call失敗時に呼び出されるエラークラス
  # Handlerはこのエラーをキャッチしてrollbackメソッドを実行する
  class ServiceError < StandardError;
    attr_reader :error_model
    def initialize(error_model)
      @error_model = error_model
    end
  end

  # サービスを利用するクラスが呼び出すメソッド
  # 内部でperformメソッドを呼び出し、処理が失敗している場合は例外を投げる
  def call
    # result = perform
    # raise ServiceError, "#{self.class}の処理が失敗しました" unless result

    # result
    perform
    raise ServiceError.new(error_model), error_message if failed
  end

  private

  attr_reader :failed, :error_message, :error_model

  # 実際の処理を記述するメソッド
  # 継承元のクラスはこのメソッドをオーバーライドする
  def perform
    raise NotImplementedError, "You must implement #{self.class}##{__method__}"
  end

  # performメソッド内で処理の失敗を明記したい場合はservice_failedメソッドを使う
  # 引数messageは例外が所持するエラーメッセージを指定することができる
  # 引数modelは例外クラスに値を渡すことができる
  def service_failed(message: "#{self.class}の処理が失敗しました", model: nil)
    @failed = true
    @error_message = message
    @error_model = model
  end
end
