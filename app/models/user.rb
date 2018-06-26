class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :validatable

  #constants
  VALID_EMAIL_REGEX = /\A[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*\z/

  #validations
  validates :user_name,  :email, :password, presence: true
  validates :email, format: {with: VALID_EMAIL_REGEX,
    message: I18n.t("model.user.valid_email") }
  validates :password, length: { minimum: 3,
    message: I18n.t("model.user.valid_password")}
end
