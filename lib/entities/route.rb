require_relative '../modules/instance_counter'

class Route
  include InstanceCounter

  @@routes = []

  def self.all
    @@routes
  end

  attr_reader :stations

  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
    validate!
    @@routes << self

    register_instance
  end

  def valid?
    validate!
    true
  rescue RuntimeError
    false
  end

  def first_station
    stations.first
  end

  def last_station
    stations.last
  end

  def add_station(station, position = -2)
    return if stations.include?(station)

    stations.insert(position, station)
  end

  def show_stations
    stations_list.join(' - ')
  end

  def delete_station(station)
    return if [first_station, last_station].include?(station)

    stations.delete(station)
  end

  private

  def stations_list
    stations.map(&:name)
  end

  def validate!
    raise 'wrong station class' unless @stations.all? { |s| s.class == Station }
  end

  # def to_hash
  #   stations.each_with_object({}) { |item, acc| acc[item.name] = item }
  # end
end
