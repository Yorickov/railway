require_relative '../modules/company'

class Train
  include Company

  def self.types
    { passenger: PassengerTrain, cargo: CargoTrain }
  end

  attr_reader :id, :speed, :current_station, :route

  def initialize(id)
    @id = id
    @carriages = []
    @speed = 0
  end

  def speed_up(step = 1)
    @speed += step
  end

  def slow_down
    @speed = 0
  end

  def carriages_count
    carriages.size
  end

  def add_carriage(carriage)
    if speed.positive?
      puts 'train is running'
    elsif !valid_carriage?(carriage)
      puts 'wrong carriage'
    else
      @carriages << carriage
    end
  end

  def remove_carriage
    if speed.positive?
      puts 'train is running'
    elsif carriages_count.zero?
      puts 'no more carriages'
    else
      carriages.pop
    end
  end

  def add_route=(route)
    @route = route
    @current_station = route.first_station
    current_station.add_train(self)
  end

  def to_next_station
    if next_station
      current_station.send_train(self)
      @current_station = next_station
      current_station.add_train(self)
    else
      puts 'it is the last station'
    end
  end

  def to_previous_station
    if previous_station
      current_station.send_train(self)
      @current_station = previous_station
      current_station.add_train(self)
    else
      puts 'it is the first station'
    end
  end

  def info
    if @route
      "Train No #{id}, type: #{type}, " \
      "#{route.first_station.name} - #{route.last_station.name}"
    else
      "Train No #{id}, type: #{type}"
    end
  end

  protected

  # не нужен для интерфейса, для подсчета вагонов введен carriages_count

  attr_reader :carriages

  # внутренние методы, которые используют или будуть использовать
  # интерфейсные - to_next_station, show_next_station, etc

  def next_station
    return if route.last_station == current_station

    new_station_index = route.stations.index(current_station) + 1
    route.stations[new_station_index]
  end

  def previous_station
    return if route.first_station == current_station

    new_station_index = route.stations.index(current_station) - 1
    route.stations[new_station_index]
  end
end
