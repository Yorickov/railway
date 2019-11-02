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
    if stations.include?(station)
      puts 'This station is already in route'
    else
      stations.insert(position, station)
    end
  end

  def show_stations
    station_list.join(' - ')
  end

  def delete_station(station)
    if [first_station, last_station].include?(station)
      puts 'station can not be removed'
    else
      stations.delete(station)
    end
  end

  def station_list
    stations.map(&:name)
  end

  # def to_hash
  #   stations.each_with_object({}) { |item, acc| acc[item.name] = item }
  # end
end
