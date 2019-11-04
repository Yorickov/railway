class StationService < Service
  def initialize(options)
    @station_klass = options[:station_klass]
  end

  def create_station_console
    puts 'enter station name'

    name = gets.chomp
    create_station_console if name == ''

    if station_klass.stations_list.include?(name)
      puts 'there is already such a station'
      create_station_console
    else
      create_station(name)
    end
  end

  def show_station_trains
    if station_klass.all.empty?
      puts 'there is no stations'
      return
    end

    puts 'enter index of station or X to exit' # TODO

    station_index = input_index(station_klass.stations_list)
    station_klass.all.values[station_index.to_i].show_trains
  end

  # add search by route?
  def show_stations
    station_klass.stations_list.each { |name| puts name }
  end

  private

  attr_reader :station_klass

  def create_station(name)
    station = @station_klass.new(name)
    station
  end
end
