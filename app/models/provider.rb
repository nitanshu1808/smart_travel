class Provider < ApplicationRecord
	#validations
	validates_presence_of :provider_uid, :provider
  validates_uniqueness_of :provider_uid, scope: :provider

	#associations
	belongs_to :user, inverse_of: :provider
end
