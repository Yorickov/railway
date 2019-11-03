class Station
  @@stations = []

  def self.all
    @@stations
  end

  def self.stations_list
    @@stations.map(&:name)
  end

  def self.find(name)
    @@stations.find { |s| s.name == name }
  end

  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
    @@stations << self
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
