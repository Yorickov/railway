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

  def show_station_trains
    if station_klass.all.empty?
      puts 'there is no stations'
      return
    end

    station_index = input_index(station_klass.stations_list, 'station')
    station_klass.all[station_index.to_i].show_trains if station_index
  end

  def show_stations
    if station_klass.all.empty?
      puts 'there is no stations'
      return
    end

    station_klass.stations_list.each { |name| puts name }
  end

  private

  attr_reader :station_klass

  def create_station(name) # delete
    @station_klass.new(name)
  end
end
