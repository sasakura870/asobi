class ApplicationService
  # サービスを利用するクラスが呼び出すメソッド
  def call
    raise NotImplementedError.new("You must implement #{self.class}##{__method__}")
  end
end
