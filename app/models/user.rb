class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :validatable, :omniauthable, :omniauth_providers => [:facebook]

  #constants
  VALID_EMAIL_REGEX = /\A[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*\z/

  #validations
  validates :user_name,  :email, :password, presence: true
  validates :email, format: {with: VALID_EMAIL_REGEX,
    message: I18n.t("model.user.valid_email") }
  validates :password, length: { minimum: 3,
    message: I18n.t("model.user.valid_password")}

  #associations
  has_one :provider, inverse_of: :user, dependent: :destroy

  #nested_attributes
  accepts_nested_attributes_for :provider

  #scope
  scope :social_ntwrk_users, ->(email, provider_uid, provider){joins(:provider).where("users.email = ? and providers.provider_uid = ? and providers.provider = ?", email, provider_uid, provider)}

  #class methods
  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def self.from_omniauth(auth)
    user = User.social_ntwrk_users(auth.info.email, auth.uid, auth.provider)
    if user.present?
      user.first
    else
      begin
        create!(initialize_provider_user(auth))
      rescue Exception => e
        puts e.message
        return {}
      end
    end
  end

  private
  def self.initialize_provider_user(auth)
    {
      email:        auth.info.email,
      user_name:    auth.info.name,
      password:     Devise.friendly_token[0,20],
      image:        auth.info.image,
      provider_attributes: {
        provider:         auth.provider,
        provider_uid:     auth.uid
      }
    }
  end
end
