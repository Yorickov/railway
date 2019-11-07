class StationService < Service
  def initialize(options)
    @station_klass = options[:station_klass]
  end

  def create_station_console
    puts 'enter station name or X to exit'

    name = gets.chomp
    return if name.downcase == 'x'

    create_station(name)
  rescue => e
    puts e.message
    retry
  end

  def show_station_trains # => to one interface
    station = find_station
    unless station
      puts 'there is no stations'
      return
    end

    station.show_trains
  end

  def show_train_carriages # => to one interface
    station = find_station
    unless station
      puts 'there is no stations'
      return
    end

    train_index = input_index(station.trains.map(&:info), 'train')
    train = station.trains[train_index.to_i] if train_index

    train.show_carriages
  end

  def show_stations
    if station_klass.all.empty?
      puts 'there is no stations'
      return
    end

    station_klass.stations_list.each { |name| puts name }
  end

  def fill_train_carriages # => to one interface
    station = find_station
    unless station
      puts 'there is no stations'
      return
    end

    train_index = input_index(station.trains.map(&:info), 'train')
    train = station.trains[train_index.to_i] if train_index

    carriage_index = input_index(train.carriages.map(&:info), 'carriage')
    carriage = train.carriages[carriage_index.to_i] if carriage_index

    carriage.load
    carriage.info
  end

  private

  attr_reader :station_klass

  def find_station
    return if station_klass.all.empty?

    station_index = input_index(station_klass.stations_list, 'station')
    station_klass.all[station_index.to_i] if station_index
  end

  def create_station(name)
    @station_klass.new(name)
  end
end
