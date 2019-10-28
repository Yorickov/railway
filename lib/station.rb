class Station
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def add_train(train)
    @trains << train
  end

  def show_trains
    trains.each { |t| puts t.id }
  end

  def show_trains_by_type(type)
    selected = trains.select { |t| t.type == type }
    selected.each { |t| puts t.id }
  end

  def send_train(train)
    trains.delete(train)
  end
end
