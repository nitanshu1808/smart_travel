class History < ApplicationRecord
  def self.competing_price
    Rails.cache.fetch("bus_list", expires_in: 12.hours) do
      travel = TravelCache.new
      travel.fetch_bus_information
    end
  end
end
