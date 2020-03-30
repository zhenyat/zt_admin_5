################################################################################
# Model:  User
#
# Purpose:
#
# User attributes:
#   role              - enum
#   last_name         - string:
#   first_name        - string:
#   email             - string,  not NULL, unique
#   password_digest   - string, not NULL
#   remember_token    - rstring
#   status            - enum { active (0) | archived (1) }
#
#   07.07.2016  ZT
#   30.03.2020  enum syntax updated
################################################################################
class User < ApplicationRecord
  before_save {self.email.downcase!}

  enum role:   ['manager', 'admin', 'sysadmin']
  enum status: ['active,' 'archived']

  validates :last_name,  presence: true
  validates :first_name, presence: true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}

  has_secure_password                      # validates presence of password & password_confirmation
  validates :password, length: {minimum: 8}


  # Returns an User full name
  def full_name
    "#{last_name} #{first_name}"
  end

  private

    # Returns a random token
    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end

    # Returns a random token.
    def User.new_token
      SecureRandom.urlsafe_base64
    end

    # Remembers a user in the database to apply him/her in persistent sessions
    def remember
      self.remember_token = User.new_token
      update_attribute(:remember_digest, User.digest(remember_token))
    end

    # Returns true if the given token matches the digest.
    def authenticated?(remember_token)
      BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end
end
