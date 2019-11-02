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

  # def train_list
  #   trains.map(&:id)
  # end
end
