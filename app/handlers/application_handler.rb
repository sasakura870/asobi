class ApplicationHandler
  # Serviceクラスを呼び出すクラス
  # 継承元のクラスは、オーバーライドしたhandleメソッドでServiceクラスを呼び出す
  # 呼び出したServiceで失敗した場合は、handleメソッドを中断してrollbackメソッドを呼び出す
  # Serviceクラスが失敗した場合に何か処理を行いたい場合はrollbackメソッドをオーバーライドする
  # runメソッドは、handleメソッド内の全てのServiceクラスの処理が正常に終わればtrue, どれかが失敗すればfalseが返る

  # runメソッドの返り値として渡されるクラス
  # 内部の値を変更したい場合は、handleメソッド内でhandle_succeededメソッドを呼び出す
  # Serviceクラスの処理内でServiceErrorが出た場合は、その例外の値が代入される
  class HandleResult
    attr_reader :result, :message, :model

    def initialize(result, message, model)
      @result = result
      @message = message
      @model = model
    end
  end

  # 複数のServiceを呼び出すメソッド
  # 返り値にHandleResultクラスが返る
  def run
    handle
    HandleResult.new(true, message, model)
  rescue ApplicationService::ServiceError => e
    HandleResult.new(false, e.message, e.model)
  end

  protected

  # サービスを実行するメソッド
  # 継承先のクラスはこのメソッドをオーバーライドする
  def handle
    raise NotImplementedError, "You must implement #{self.class}##{__method__}"
  end

  def handle_succeeded(message: "#{self.class}の処理に成功しました", model: nil)
    @message = message
    @model = model
  end

  private

  attr_reader :message, :model
end
