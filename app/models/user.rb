class User < ApplicationRecord
  validates :username, :password_digest, :session_token, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }

  attr_reader :password

  after_initialize :ensure_token

  has_many :subs,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :Sub

  has_many :posts,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :Post

  has_many :comments

  def self.find_by_credentials(username, pw)
    user = User.find_by(username: username)
    return nil unless user && user.is_password?(pw)
    user
  end

  def ensure_token
    self.session_token ||= SecureRandom.urlsafe_base64
  end

  def reset_token!
    self.session_token = SecureRandom.urlsafe_base64
    self.save
    self.session_token
  end

  def password=(pw)
    @password = pw
    self.password_digest = BCrypt::Password.create(pw)
  end

  def is_password?(pw)
    BCrpyt::Password.new(self.password_digest).is_password?(pw)
  end
end
