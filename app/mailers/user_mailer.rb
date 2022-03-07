class UserMailer < ApplicationMailer
  def account_activation user
    @user = user
    mail to: user.email, subject: t("users.email.account_activation")
  end

  def password_reset user
    @user = user
    mail to: user.email, subject: t("users.email.reset")
  end
end
