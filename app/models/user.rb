class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :validatable, :omniauthable, :omniauth_providers => [:facebook]

  #constants
  VALID_EMAIL_REGEX = /\A[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*\z/
  FILTER_SPECIAL_CHARACTERS = /[^0-9A-Za-z]/

  #validations
  validates :user_name,  :email, :password, presence: true
  validates :email, format: {with: VALID_EMAIL_REGEX,
    message: I18n.t("model.user.valid_email") }
  validates :password, length: { minimum: 3,
    message: I18n.t("model.user.valid_password")}

  #associations
  has_one :provider, inverse_of: :user, dependent: :destroy
  has_many :histories, inverse_of: :user, dependent: :destroy

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
    user            = User.find_by(email: auth.info.email)
    omniauth_user   = user.provider if user
    if user.present?
      (omniauth_user && user) || User.initialize_and_add_error(auth)
    else
      begin
        create!(initialize_provider_user(auth))
      rescue Exception => e
        puts e.message
      end
    end
  end

  def self.bus_list(coordinates=nil)
    Rails.cache.fetch("bus_list", expires_in: 12.hours) do
      begin
        travel = TravelCache.new
        travel.fetch_bus_information["results"].uniq{|result| result["shortname"]}  
      rescue Exception => e
        @retries ||= 0
        if @retries == 0
          @retries = 1
          retry
        else
          raise error
        end
      end
    end
    coordinates && filter_bus_list(coordinates) || bus_cache
  end

  def initialize_bus_histories(data)
    histories.build({
      stop_name:    data["shortname"],
      stop_id:      data["stopid"],
      history_type: "bus"
    })
  end

  def searched_history(type)
    histories.where("history_type = ?", type)
  end

  def self.bike_list(coordinates=nil)
    Rails.cache.fetch("bike_list", expires_in: 12.hours) do
      travel = TravelCache.new
      travel.fetch_bike_information
    end
    coordinates && sort_records(coordinates) || bikes_cache
  end

  def initialize_bike_histories(data)
    histories.build({
      stop_name:    data["name"],
      stop_id:      data["number"],
      history_type: "bike"
    })
  end

  def self.initialize_and_add_error(auth)
    new({
        email:                auth.info.email,
        user_name:            auth.info.name,
        image:                auth.info.image
      })
  end

  def self.sort_records(coordinates=nil)
    data = []
    bikes_cache.each do |record|
      position = record["position"]
      data << record.merge("distance" => calculate_distance(coordinates, [position["lat"], position["lng"]] ) )
    end
    data.sort_by{|bike| bike["distance"]}.slice(0,20)
  end

  def self.calculate_distance(coordinates1, coordinates2)
    Geocoder::Calculations.distance_between(coordinates1, coordinates2, {:units => :km }).round(2) * 1000
  end

  def self.filter_bus_list(coordinates=nil)
    data = []
    bus_cache.each do |record|
      data << record.merge("distance" => calculate_distance(coordinates, [record["latitude"], record["longitude"]] ) )
    end
    data.sort_by{|bus| bus["distance"]}.slice(0,20)
  end

  def self.bus_cache
    Rails.cache.fetch("bus_list")
  end

  def self.bikes_cache
    Rails.cache.fetch("bike_list")
  end

  private
  def self.initialize_provider_user(auth)
    {
      email:                auth.info.email,
      user_name:            auth.info.name,
      password:             Devise.friendly_token[0,20],
      image:                auth.info.image,
      provider_attributes: {
        provider:         auth.provider,
        provider_uid:     auth.uid
      }
    }
  end
end
