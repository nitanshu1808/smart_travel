class TravelInfo

  def initialize(options=nil)
    @options     = options
    @list        = get_list
  end

  def fetch_bus_stop_info
    stop_id     = @options["id"]
    data = TravelApi.new({stopid: stop_id}).bus_stop_info["results"]
    if (data.size == 0) 
      return error_msg, false
    else 
      return data, true
    end
  end

  def error_msg
    "No Results found for #{@options["name"]} at this time #{TravelInfo.current_time}"
  end

  def self.current_time
    DateTime.now.strftime("%H:%M:%S %p :%Z")
  end

  def stop_information
    stop_data = stop_info
    if stop_data.present?
      TravelApi.new({stopid: stop_data["stopid"]}).bus_stop_info["results"] << stop_data
    end
  end

  def stop_info
    if @options["input"].to_i == 0
      @list.select{|k,v| k["shortname"].casecmp?(@options["input"])}.first
    else
      @list.select{|k,v| k["stopid"] == @options["input"]}.first
    end
  end

  def station_information
    station_data = station_info
    if station_data.present?
      TravelApi.new({
        "number" => station_data["number"],
        "contract"=> 'dublin',
        "apiKey" =>   ENV['DUBLIN_BIKES_KEY']})
      .bike_station_info
    end
  end

  def station_info
    if @options["input"].to_i == 0
      @list.select{|k,v| k["name"].casecmp?(@options["input"])}.first
    else
      num = @options["input"].to_i
      @list.select{|k,v| k["number"] == num}.first
    end
  end

  def get_list
    if ["dublin_bus", "bus_stop", "stop_info"].include?(@options["action"])
      User.bus_list
    else
      User.bike_list
    end
  end
end
