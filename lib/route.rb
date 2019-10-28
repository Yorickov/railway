class Route
  attr_reader :stations

  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
  end

  def add_station(station, position = -2)
    stations.insert(position, station)
  end

  def show_stations
    puts stations.map(&:name).join(', ')
  end

  def delete_station(station)
    stations.reject! { |s| s.name == station.name }
  end
end
