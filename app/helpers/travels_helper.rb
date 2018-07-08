module TravelsHelper
  def display_stop_msg
    I18n.t("web.stop_info", {id: @stop_info.last["stopid"], name: @stop_info.last["shortname"]}) if @stop_info
  end

  def verify_current_user
    current_user.present? && 1 || 2    
  end

  def verifySearchHistory
    current_user.present? && 3 || 2
  end

  def calculate_dist(res)
    lat1, lng1 = [res["position"]["lat"], res["position"]["lng"]]
    lat2, lng2 = request.location.coordinates
    # lat2, lng2 = [53.349562,  -6.278198]
    dsitance = Geocoder::Calculations.distance_between([lat1, lng1], [lat2, lng2])
    return dsitance <= 0.621371 ? false : true
  end

  def fetch_action
    check_action ? "/stop_info" : "/station_info"
  end

  def display_station_msg
    I18n.t("web.station_info", {num: @station_info["number"], name: @station_info["name"]}) if @station_info
  end

  def transport_url(history)
    check_action && stop_info_url(input: history.stop_id) || station_info_url(input: history.stop_id)
  end

  def check_action
    (params["action"] == "dublin_bus" || params["action"] == "stop_info")
  end
end
