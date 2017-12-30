class User < ApplicationRecord
  has_many :posts, dependent: :nullify

  has_secure_password

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  # validate the email field as format and if it's filled
  validates :email, presence: true, uniqueness: true, format: VALID_EMAIL_REGEX

  # `validates` can take multiple column names as its first arguments. All
  # validation rules provided will apply all given columns.
  validates :first_name, :last_name, presence: true

  def full_name
    "#{first_name} #{last_name}" #put self if wants do write, not for reading
  end

end
