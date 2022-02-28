class User < ApplicationRecord
  before_save :email_downcase
  validates :name, presence: true,
    length: {maximum: Settings.settings.user.username.max_length}
  validates :email, presence: true,
    length: {maximum: Settings.settings.user.email.max_length},
    format: {with: Settings.settings.user.email.regex},
    uniqueness: true
  has_secure_password
  validates :password, presence: true,
    length: {minimum: Settings.settings.user.password.min_length}

  private
  def email_downcase
    self.email = email.downcase
  end
end
