class ApplicationHandler
  # Serviceクラスを呼び出すクラス
  # 継承元のクラスは、オーバーライドしたhandleメソッドでServiceクラスを呼び出す
  # 呼び出したServiceで失敗した場合は、handleメソッドを中断してrollbackメソッドを呼び出す
  # Serviceクラスが失敗した場合に何か処理を行いたい場合はrollbackメソッドをオーバーライドする
  # runメソッドは、handleメソッド内の全てのServiceクラスの処理が正常に終わればtrue, どれかが失敗すればfalseが返る

  # fail_message : Serviceクラスの処理が失敗した際に渡されるエラーメッセージ
  # fail_model : Serviceクラスの処理が失敗した際に渡される値(モデルのsave, updateの失敗時のモデルが渡ることを想定している)
  attr_reader :fail_message, :fail_model

  # 複数のServiceを呼び出すメソッド
  def run
    handle
    true
  rescue ApplicationService::ServiceError => e
    @fail_message = e.message
    @fail_model = e.error_model
    rollback
    false
  end

  private

  # サービスを実行するメソッド
  # 継承先のクラスはこのメソッドをオーバーライドする
  def handle
    raise NotImplementedError, "You must implement #{self.class}##{__method__}"
  end

  # サービスが失敗した場合に呼び出されるメソッド
  # handle内のサービスがどれか失敗した場合に行いたい処理がある場合は、このメソッドをオーバーライドする
  def rollback; end
end
