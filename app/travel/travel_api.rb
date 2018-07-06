class TravelApi

  def initialize(options=nil)
    @options = options || fetch_options
  end

  def nearby_bus_stops
    url = TRAVEL_API["google_map_api"] + TRAVEL_API["nearby_search_place"] + TRAVEL_API["response_type"]
    get_response(url)
  end

  def bus_stop_info
    url = TRAVEL_API["dublin_bus"] + TRAVEL_API["realtimebusinformation"]
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

  private
  def fetch_options
    {
      location: "53.350140, -6.266155",
      radius: 1000,
      open_now: true,
      key: ENV['GOOGLE_API_KEY'],
      type: "bus_station"
    }
  end
end
