require_relative '../modules/instance_counter'

class Station
  include InstanceCounter

  @@stations = []

  NAME_FORMAT = /^[a-z0-9\- ]+$/i.freeze

  attr_accessor :name
  attr_reader :trains

  def self.all
    @@stations
  end

  def self.stations_list
    @@stations.map(&:name)
  end

  def self.find(name)
    @@stations.find { |s| s.name == name }
  end

  def initialize(name)
    @name = name
    validate!

    @trains = []
    @@stations << self

    register_instance
  end

  def valid?
    validate!
    true
  rescue RuntimeError
    false
  end

  def add_train(train)
    @trains << train
  end

  def show_trains
    each_train { |t| puts t.info }
  end

  def show_trains_by_type(type)
    trains
      .select { |t| t.type == type }
      .each { |t| puts t.info }
  end

  def send_train(train)
    trains.delete(train)
  end

  protected

  def each_train
    trains.each { |t| yield(t) }
  end

  def validate!
    raise 'You must input smth.' if name.strip.size.zero?
    raise 'Name should not be more than 15 symbols' if name.strip.size > 15
    raise 'Name has invalid format' if name.strip !~ NAME_FORMAT
    raise 'there is such a name' if self.class.stations_list.include?(name)
  end
end
