require_relative '../modules/instance_counter'
require_relative '../modules/accessors'
require_relative '../modules/validation'

class Station
  include InstanceCounter
  include Accessors
  include Validation

  @@stations = []

  NAME_FORMAT = /^[a-z0-9\- ]+$/i.freeze

  attr_accessor :name
  attr_reader :trains

  validate :name, :presence
  validate :name, :format, NAME_FORMAT
  validate :name, :uniqueness, self

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
end
