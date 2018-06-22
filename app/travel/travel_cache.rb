class TravelCache

  def initialize(options={})
    @options = options
  end

  def fetch_bus_information
    puts("#{TRAVEL_API["dublin_bus"] + TRAVEL_API["bus_stop"]}")
    begin
      response = RestClient.get TRAVEL_API["dublin_bus"] + TRAVEL_API["bus_stop"], {:params => @options}
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
