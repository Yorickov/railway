class Route
  attr_reader :stations

  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
  end

  def first_station
    stations.first
  end

  def last_station
    stations.last
  end

  def add_station(station, position = -2)
    stations.insert(position, station)
  end

  def show_stations
    stations.each { |s| puts s.name }
  end

  def delete_station(station)
    if [first_station, last_station].include?(station)
      puts 'station can not be removed'
    else
      stations.delete(station)
    end
  end
end
