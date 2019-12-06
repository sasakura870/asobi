class UserMailer < ApplicationMailer
  def account_activation(user)
    @user = user

    mail to: user.email,
         subject: '本登録を完了してください'
  end

  def email_resetting(user)
    @user = user

    mail to: user.email,
         subject: 'メールアドレスのご確認'
  end
end
