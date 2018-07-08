class TravelsController < ApplicationController
  def index
  end

  def dublin_bus
    nearby_stops    = TravelApi.new.nearby_bus_stops
    @results        = nearby_stops && nearby_stops["results"]
    @search_history = current_user.searched_history('bus') if current_user
  end

  def dublin_bikes
    @bike_list    = User.bike_list
    @search_history = current_user.searched_history('bike') if current_user
  end

  def bus_stop
    result, is_valid = TravelInfo.new(params).fetch_bus_stop_info
    render json: {data: result, is_valid: is_valid}
  end

  def stop_info
    @stop_info = TravelInfo.new(params).stop_information
    create_history
    render :nothing => true, :status => 200, :content_type => 'text/html' unless @stop_info.present?
  end

  def station_info
    @station_info = TravelInfo.new(params).station_information
    create_bike_history
    render :nothing => true, :status => 200, :content_type => 'text/html' unless @station_info.present?
  end

  private
  def create_history
    if current_user && @stop_info.last && @stop_info.last["stopid"]
      history = current_user.initialize_bus_histories(@stop_info.last)
      history.save
    end
  end

  def create_bike_history
    if current_user && @station_info
      history = current_user.initialize_bike_histories(@station_info)
      history.save
    end    
  end
end
