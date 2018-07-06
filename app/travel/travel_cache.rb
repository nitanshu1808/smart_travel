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
end
