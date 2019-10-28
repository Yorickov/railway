class Route
  attr_reader :stations

  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
  end

  def add_station(station, position = -2)
    stations.insert(position, station)
  end

  def show_stations
    stations.each { |s| puts s.name }
  end

  def delete_station(station)
    station_index = stations.find_index(station)

    if station_index.zero? || station_index == stations.length - 1
      puts 'station can not be removed'
    else
      stations.delete(station)
    end
  end
end
