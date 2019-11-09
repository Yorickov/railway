require_relative '../modules/instance_counter'
require_relative '../modules/accessors'
require_relative '../modules/validation'

class Route
  include InstanceCounter
  include Accessors
  include Validation

  @@routes = []

  def self.all
    @@routes
  end

  attr_reader :stations

  validate :stations, :type, Array

  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
    validate!
    @@routes << self

    register_instance
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
end
