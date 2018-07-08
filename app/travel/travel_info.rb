class TravelInfo

  def initialize(options=nil)
    @options     = options
    @list        = get_list
  end

  def fetch_bus_stop_info
    stop_info   = @list.select{|k,v| k["shortname"] == @options["name"]}.first
    stop_id     = stop_info && stop_info["stopid"]
    return error_msg, false if stop_id.nil?
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
      @list.select{|k,v| k["shortname"] == @options["input"]}.first
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
      @list.select{|k,v| k["name"] == @options["input"]}.first
    else
      @list.select{|k,v| k["number"] == @options["input"]}.first
    end
  end

  def get_list
    if @options["action"] == "dublin_bus" || @options["action"] == "dublin_bus"
      User.bus_list["results"]
   else
      User.bike_list
   end
  end
end
