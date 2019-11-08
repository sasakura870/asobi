class ApplicationServiceHandler
  # 複数のServiceを呼び出すメソッド
  def run
    raise NotImplementedError, "You must implement #{self.class}##{__method__}"
  end
end
