class TravelsController < ApplicationController
  before_action :find_search_history, only: [:dublin_bus, :dublin_bikes], if: -> { current_user.present? }

  def index
  end

  def dublin_bus
    @results        = User.bus_list(coordinates)
  end

  def dublin_bikes
    @bike_list      = User.bike_list(coordinates)
  end

  def bus_stop
    result, is_valid = TravelInfo.new(params).fetch_bus_stop_info
    render json: {data: result, is_valid: is_valid}
  end

  def stop_info
    @stop_info = TravelInfo.new(params).stop_information
    if @stop_info.present?
      create_history  
    else
      redirect_to dublin_bus_url, notice: I18n.t("web.no_search_result")
    end
  end

  def station_info
    @station_info = TravelInfo.new(params).station_information
    if @station_info.present?
      create_bike_history
    else
      redirect_to dublin_bikes_url, notice: I18n.t("web.no_search_result")
    end    
  end

  private
  def create_history
    if current_user && @stop_info && @stop_info.last["stopid"]
      history = current_user.initialize_bus_histories(@stop_info.last)
      history.valid? && history.save
    end
  end

  def create_bike_history
    if current_user && @station_info
      history = current_user.initialize_bike_histories(@station_info)
      history.valid? && history.save
    end    
  end

  def fetch_options
    {
      location: "#{request.location.coordinates[0]},#{request.location.coordinates[1]}",
      radius: 1000,
      open_now: true,
      key: ENV['GOOGLE_API_KEY'],
      type: "bus_station"
    }
  end

  def coordinates
    request.location.coordinates
  end

  def find_search_history
    type = params["action"] == "dublin_bus" ? "bus" : "bike"
    @search_history = current_user.searched_history(type)
  end
end
