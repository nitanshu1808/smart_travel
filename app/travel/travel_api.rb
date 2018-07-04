class TravelApi

  def initialize
    @options = fetch_options
  end

  def nearby_bus_stops
    puts("#{TRAVEL_API["google_map_api"] + TRAVEL_API["nearby_search_place"] + TRAVEL_API["response_type"]}") if Rails.env.development?
    begin
      response = RestClient.get TRAVEL_API["google_map_api"] + TRAVEL_API["nearby_search_place"] + TRAVEL_API["response_type"], {:params => @options}
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

  def fetch_options
    {
      location: "53.350140, -6.266155",
      radius: 1000,
      open_now: true,
      key: ENV['GOOGLE_API_KEY']
    }
  end
end
