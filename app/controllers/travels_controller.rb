class TravelsController < ApplicationController
  def index
  end

  def dublin_bus
    # History.competing_price
    nearby_stops = TravelApi.new.nearby_bus_stops
    @results     = nearby_stops && nearby_stops["results"]
  end

  def dublin_bikes
  end
end
