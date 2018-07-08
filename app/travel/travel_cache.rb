class TravelCache

  def initialize(options={})
    @options = options
  end

  def fetch_bus_information
    url = TRAVEL_API["dublin_bus"] + TRAVEL_API["bus_stop"]
    TravelApi.new(dublin_bus_operator).get_response(url)
  end

  def dublin_bus_operator
    {operator: "bac"}
  end

  def fetch_bike_station
    url = TRAVEL_API["dublin_bikes"] + TRAVEL_API["stations"] + "/#{options["station_number"]}"
    TravelApi.new(bike_info).get_response(url)    
  end

  def fetch_bike_information
    url = TRAVEL_API["dublin_bikes"] + TRAVEL_API["stations"]
    TravelApi.new(bike_info).get_response(url)    
  end

  def bike_info
    {
      contract: 'dublin',
      apiKey:   ENV['DUBLIN_BIKES_KEY']
    }
  end
end
