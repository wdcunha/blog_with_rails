class User < ApplicationRecord
  attr_accessor :reset_token
  has_many :comments, dependent: :nullify
  has_many :posts, dependent: :nullify
  before_save   :downcase_email
  has_secure_password
#
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
#
  # validate the email field as format and if it's filled
  validates :email, presence: true, uniqueness: true, format: VALID_EMAIL_REGEX

  # `validates` can take multiple column names as its first arguments. All
  # validation rules provided will apply all given columns.
  validates :first_name, :last_name, presence: true, length: {maximum: 50}

  # Sets the password reset attributes.
  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest,  User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end
#
#   # Sends password reset email.
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end
#
  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
    BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
#
  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Returns true if the given token matches the digest.
  def authenticated?(attribute, token)
   digest = send("#{attribute}_digest")
   return false if digest.nil?
   BCrypt::Password.new(digest).is_password?(token)
  end

  # Converts email to all lower-case.
  def full_name
    "#{first_name} #{last_name}" #put self if wants do write, not for reading
  end

  # Returns true if a password reset has expired.
  def password_reset_expired?
    reset_sent_at < 3.days.ago
  end

  private

  def downcase_email
    self.email = email.downcase
  end

end
