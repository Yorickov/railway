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

  def manage_station_process(station)
    puts 'enter T to show station trains, C to show carriage, ' \
    'F to fill carriage or X to exit'

    choice = gets.chomp.downcase
    return if choice == 'x'

    case choice
    when 't'
      show_station_trains(station)
    when 'c'
      manage_train_carriages(station, true)
    when 'f'
      manage_train_carriages(station, false)
    else
      manage_station_process(station)
    end
    manage_station_process(station)
  end

  def show_station_trains(station)
    station.show_trains
  end

  def manage_train_carriages(station, flag) # 2 functions
    train_index = input_index(station.trains.map(&:info), 'train')
    train = station.trains[train_index.to_i] if train_index

    if train.carriages_count.zero?
      puts 'there is no carriages'
      return
    end

    if flag
      train.show_carriages
    else
      carriage_index = input_index(train.carriages.map(&:info), 'carriage')
      carriage = train.carriages[carriage_index.to_i] if carriage_index
      carriage.load
      carriage.info
    end
  end

  private

  attr_reader :station_klass

  def find_station
    station_index = input_index(station_klass.stations_list, 'station')
    station_klass.all[station_index.to_i] if station_index
  end

  def create_station(name)
    @station_klass.new(name)
  end
end
