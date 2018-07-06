class TravelInfo
  def initialize(options={})
    @options = options
  end

  def fetch_bus_stop_info
    bus_list    = User.bus_list["results"]
    stop_info   = bus_list.select{|k,v| k["shortname"] == @options["name"]}.first
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
end
