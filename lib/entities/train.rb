require_relative '../modules/company'
require_relative '../modules/instance_counter'
require_relative '../modules/accessors'
# require_relative '../modules/validation'

class Train
  include Company
  include InstanceCounter
  include Accessors
  # include Validation

  @@trains = {}

  # NUMBER_FORMAT = /^[a-z0-9]{3}-?[a-z0-9]{2}$/i.freeze

  attr_accessor :number
  attr_reader :speed, :current_station, :route, :carriages

  # validate :number, :presence
  # validate :number, :format, NUMBER_FORMAT
  # validate :number, :uniqueness, self

  def self.all
    @@trains
  end

  def self.trains_list
    @@trains.keys
  end

  def self.find(number)
    @@trains[number]
  end

  def self.types
    { passenger: PassengerTrain, cargo: CargoTrain }
  end

  def initialize(number)
    @number = number
    validate!

    @carriages = []
    @speed = 0
    @@trains[number] = self

    register_instance
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
      carriage.number = carriages_count + 1
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
    str = "Train No #{number}, type: #{type}, carriages: #{carriages_count}"
    return str unless @route

    "#{str}, #{route.first_station.name} - #{route.last_station.name}"
  end

  def show_carriages
    each_carriage { |c| puts c.info }
  end

  protected

  def each_carriage
    carriages.each { |c| yield(c) }
  end

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
