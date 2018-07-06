class TravelsController < ApplicationController
  def index
  end

  def dublin_bus
    nearby_stops = TravelApi.new.nearby_bus_stops
    @results     = nearby_stops && nearby_stops["results"]
  end

  def dublin_bikes
  end

  def bus_stop
    result, is_valid = TravelInfo.new(params).fetch_bus_stop_info
    render json: {data: result, is_valid: is_valid}
  end
end
