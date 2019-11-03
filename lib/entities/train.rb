require_relative '../modules/company'

class Train
  include Company

  @@trains = []

  def self.all
    @@trains
  end

  def self.trains_list
    @@trains.map(&:number)
  end

  def self.find(number)
    @@trains.find { |t| t.number == number }
  end

  def self.types
    { passenger: PassengerTrain, cargo: CargoTrain }
  end

  attr_reader :number, :speed, :current_station, :route

  def initialize(number)
    @number = number
    @carriages = []
    @speed = 0
    @@trains << self
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
      "Train No #{number}, type: #{type}, " \
      "#{route.first_station.name} - #{route.last_station.name}"
    else
      "Train No #{number}, type: #{type}"
    end
  end

  protected

  attr_reader :carriages

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
