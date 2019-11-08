class StationService < Service
  def initialize(options)
    @station_klass = options[:station_klass]
  end

  def create_station_console
    puts 'enter station name or X to exit'

    name = gets.chomp
    return if name.downcase == 'x'

    create_station(name)
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def show_stations
    if station_klass.all.empty?
      puts 'there is no stations'
      return
    end

    station_klass.stations_list.each { |name| puts name }
  end

  def manage_station
    if station_klass.all.empty?
      puts 'there is no routes'
      return
    end

    station = find_station
    if station.trains.empty?
      puts 'there is no trains'
      return
    end

    manage_station_process(station)
  end

  private

  attr_reader :station_klass

  def create_station(name)
    @station_klass.new(name)
  end

  def find_station
    station_index = input_index(station_klass.stations_list, 'station')
    station_klass.all[station_index.to_i] if station_index
  end

  def manage_station_process(station)
    puts 'enter T to show trains, M to manage carriage, or X to exit'

    choice = gets.chomp.downcase
    case choice
    when 't'
      show_station_trains(station)
    when 'm'
      train = find_station_train(station)
      manage_carriages(station, train) if train
    when 'x'
      return
    else
      manage_station_process(station)
    end
    manage_station_process(station)
  end

  def show_station_trains(station)
    station.show_trains
  end

  def find_station_train(station)
    train_index = input_index(station.trains.map(&:info), 'train')
    station.trains[train_index.to_i] if train_index
  end

  def manage_carriages(station, train)
    if train.carriages_count.zero?
      puts 'there is no carriages'
      return
    end

    puts 'enter S to show carriages, L to load carriage, or X to exit'

    choice = gets.chomp.downcase
    case choice
    when 's'
      train.show_carriages
    when 'l'
      load_carriages(train)
    when 'x'
      return
    else
      manage_carriages(station, train)
    end
    manage_carriages(station, train)
  end

  def load_carriages(train)
    carriage_index = input_index(train.carriages.map(&:info), 'carriage')
    carriage = train.carriages[carriage_index.to_i] if carriage_index
    carriage.load
    carriage.info
  end
end
