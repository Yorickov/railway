class Train
  attr_reader :id, :type, :carriages, :speed, :current_station, :route

  def initialize(id, type)
    @id = id
    @type = type
    @carriages = []
    @speed = 0
  end

  def speed_up(step = 1)
    @speed += step
  end

  def slow_down
    @speed = 0
  end

  def add_carriage(carriage)
    @carriages << carriage if speed.zero?
  end

  def remove_carriage
    carriages.pop if speed.zero?
  end

  def add_route(route)
    @route = route
    @current_station = route.stations.first
    current_station.add_train(self)
  end

  def next_station
    new_station_index = route.stations.find_index(current_station) + 1

    if new_station_index >= route.stations.size
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
