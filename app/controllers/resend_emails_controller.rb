class ResendEmailsController < ApplicationController
  before_action :filter_only_temporary

  def create
    handler = ResendEmails::CreateHandler.new(user: current_user).run
    if handler.result
      render status: :ok, json: { type: 'info', message: '認証用メールを送信しました' }
    else
      render status: :internal_server_error,
             json: { type: 'error', message: '認証用メールを送信に失敗しました' }
    end
  end
end
