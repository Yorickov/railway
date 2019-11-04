require_relative '../modules/instance_counter'

class Station
  include InstanceCounter

  @@stations = {}

  def self.all
    @@stations
  end

  def self.stations_list
    @@stations.keys
  end

  def self.find(name)
    @@stations[name]
  end

  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
    @@stations[name] = self

    register_instance
  end

  def add_train(train)
    @trains << train
  end

  def show_trains
    trains.each { |t| puts t.info }
  end

  def show_trains_by_type(type)
    trains
      .select { |t| t.type == type }
      .each { |t| puts t.info }
  end

  def send_train(train)
    trains.delete(train)
  end
end
