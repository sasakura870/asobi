class ApplicationHandler
  # Serviceクラスを呼び出すクラス
  # 継承元のクラスは、オーバーライドしたhandleメソッドでServiceクラスを呼び出す
  # 呼び出したServiceで失敗した場合は、handleメソッドを中断してrollbackメソッドを呼び出す
  # Serviceクラスが失敗した場合に何か処理を行いたい場合はrollbackメソッドをオーバーライドする
  # runメソッドは、handleメソッド内の全てのServiceクラスの処理が正常に終わればtrue, どれかが失敗すればfalseが返る

  # success_model : Serviceクラスの処理が全て成功した際に渡される値
  # fail_message : Serviceクラスの処理が失敗した際に渡されるエラーメッセージ
  # fail_model : Serviceクラスの処理が失敗した際に渡される値(モデルのsave, updateの失敗時のモデルが渡ることを想定している)
  # attr_reader :success_model, :fail_message, :fail_model

  class HandleResult
    attr_reader :result, :message, :model

    def initialize(result, message, model)
      @result = result
      @message = message
      @model = model
    end
  end

  # 複数のServiceを呼び出すメソッド
  def run
    handle
    HandleResult.new(true, message, model)
    # @success_model = commit_data
    # true
  rescue ApplicationService::ServiceError => e
    HandleResult.new(false, e.message, e.model)
    # @fail_message = e.message
    # @fail_model = e.error_model
    # rollback
    # false
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

  # サービスが全て成功した場合に呼び出されるメソッド
  # サービスが全て成功した場合にコントローラーへ渡したい値があれば、このメソッドをオーバーライドする
  # def commit_data; end

  # サービスが失敗した場合に呼び出されるメソッド
  # handle内のサービスが失敗した場合に行いたい処理があれば、このメソッドをオーバーライドする
  # def rollback; end

  private

  attr_reader :message, :model
end
