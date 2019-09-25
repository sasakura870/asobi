class UserMailer < ApplicationMailer
  def account_activation(user)
    @user = user

    mail to: user.email,
         subject: '[Asobi]本登録を完了してください'
  end
end
