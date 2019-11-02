class StationService < Service
  attr_reader :repo

  def initialize(options)
    @repo = options[:repo]
    @entity = options[:entity]
  end

  def create_station_console
    puts 'enter station name'

    name = gets.chomp
    create_station_console if name == ''

    if repo.data.any? { |s| s.name == name }
      puts 'there is already such a station'
      create_station_console
    else
      create_station(name)
    end
  end

  def create_station(name)
    station = @entity.new(name)
    repo.save(station)
    station
  end

  def show_station_trains
    if repo.data.empty?
      puts 'there is no stations'
      return
    end

    puts 'enter index of station or X to exit' # TODO

    station_index = input_index(repo.stations_list)
    repo.data[station_index.to_i].show_trains
  end

  # add search by route?
  def show_stations
    repo.stations_list.each { |name| puts name }
  end
end
