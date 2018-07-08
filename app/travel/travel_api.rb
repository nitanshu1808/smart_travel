class TravelApi

  def initialize(options=nil)
    @options = options
  end

  def nearby_bus_stops
    url = TRAVEL_API["google_map_api"] + TRAVEL_API["nearby_search_place"] + TRAVEL_API["response_type"]
    get_response(url)
  end

  def bus_stop_info
    url = TRAVEL_API["dublin_bus"] + TRAVEL_API["realtimebusinformation"]
    get_response(url)
  end

  def bike_station_info
    url = TRAVEL_API["dublin_bikes"] + TRAVEL_API["stations"] + "/#{@options["number"]}"
    get_response(url)
  end

  def get_response(url)
    puts(url) if Rails.env.development?
    begin
      response = RestClient.get url, {:params => @options}
      JSON.parse(response)
    rescue RestClient::Unauthorized => error
      @retries ||= 0
      if @retries == 0
        @retries = 1
        retry
      else
        raise error
      end
    end   
  end
end
