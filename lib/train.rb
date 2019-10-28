class Train
  attr_reader :id, :type, :carriage_count, :speed, :current_station, :route

  def initialize(id, type, carriage_count)
    @id = id
    @type = type
    @carriage_count = carriage_count
    @speed = 0
  end

  def speed_up(step = 1)
    @speed += step
  end

  def slow_down
    @speed = 0
  end

  def add_carriage
    @carriage_count += 1 if speed.zero?
  end

  def remove_carriage
    @carriage_count -= 1 if speed.zero? && carriage_count.positive?
  end

  def add_route(route)
    @route = route
    @current_station = route.stations[0]
    current_station.add_train(self)
  end

  def next_station
    new_station_index = route.stations.find_index(current_station) + 1

    if new_station_index >= route.stations.length
      puts 'no more stations'
    else
      route.stations[new_station_index]
    end
  end

  def previous_station
    new_station_index = route.stations.find_index(current_station) - 1

    if new_station_index.negative?
      puts 'no more stations'
    else
      route.stations[new_station_index]
    end
  end

  def to_next_station
    current_station.send_train(self)
    @current_station = next_station
    current_station.add_train(self)
  end

  def to_previous_station
    current_station.send_train(self)
    @current_station = previous_station
    current_station.add_train(self)
  end
end
