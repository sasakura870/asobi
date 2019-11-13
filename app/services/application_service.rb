class ApplicationService
  # 全てのServiceクラスはこのクラスを継承する
  # 継承元のクラスはinitialize, performを実装する

  # callメソッド成功時に返り値として渡されるクラス
  # 呼び出し元にメッセージとモデルを渡すことができる
  # 内部のmessage, modelの値を変更したい場合は、performメソッド内でservice_succeededメソッドを呼び出す
  class SuccessResult
    attr_reader :message, :model

    def initialize(message:, model:)
      @message = message
      @model = model
    end
  end

  # callメソッド失敗時に呼び出されるエラークラス
  # Handlerはこのエラーをキャッチしてrollbackメソッドを実行する
  class ServiceError < StandardError
    attr_reader :model

    def initialize(model)
      @model = model
    end
  end

  # サービスを利用するクラスが呼び出すメソッド
  # 内部でperformメソッドを呼び出し、処理が失敗している場合は例外を投げる
  def call
    perform
    if failed
      raise ServiceError.new(model), message
    else
      SuccessResult.new(message: message, model: model)
    end
  end

  protected

  # 実際の処理を記述するメソッド
  # 継承元のクラスはこのメソッドをオーバーライドする
  def perform
    raise NotImplementedError, "You must implement #{self.class}##{__method__}"
  end

  # 成功時に特定のメッセージやモデルを渡したい場合はservice_succeededメソッドを使う
  # 引数で指定したmessage, modelがSuccessResultモデルに渡される
  def service_succeeded(message: "#{self.class}の処理が成功しました", model: nil)
    @failed = false
    @message = message
    @model = model
  end

  # performメソッド内で処理の失敗を明記したい場合はservice_failedメソッドを使う
  # 引数messageは例外が所持するエラーメッセージを指定することができる
  # 引数modelは例外クラスに値を渡すことができる
  def service_failed(message: "#{self.class}の処理が失敗しました", model: nil)
    @failed = true
    @message = message
    @model = model
  end

  private

  attr_reader :failed, :message, :model
end
