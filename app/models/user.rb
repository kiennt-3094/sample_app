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
    length: {minimum: Settings.settings.user.password.min_length},
    allow_nil: true
  private
  def email_downcase
    self.email = email.downcase
  end

  attr_accessor :remember_token

  class << self
    def digest string
      cost = if ActiveModel::SecurePassword.min_cost
               BCrypt::Engine::MIN_COST
             else
               BCrypt::Engine.cost
             end
      BCrypt::Password.create string, cost: cost
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def remember
    self.remember_token = User.new_token
    update_column :remember_digest, User.digest(remember_token)
  end

  def authenticated? remember_token
    return false unless remember_digest

    BCrypt::Password.new(remember_digest).is_password? remember_token
  end

  def forget
    update_column :remember_digest, nil
  end
end
