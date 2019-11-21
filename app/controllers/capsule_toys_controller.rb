class CapsuleToysController < ApplicationController
  def index
    # 記事を取ってくる
    # それ用に整形する
    render :index, formats: :json, handlers: :jbuilder
  end
end
