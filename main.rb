require_relative 'lib/station'
require_relative 'lib/route'

require_relative 'lib/train'
require_relative 'lib/passenger_train'
require_relative 'lib/cargo_train'

require_relative 'lib/carriage'
require_relative 'lib/passenger_carriage'
require_relative 'lib/cargo_carriage'

@stations = {}

def create_station!(name)
  station = Station.new(name)
  @stations[name] = station
end

def create_station_console
  puts 'enter station name'

  name = gets.chomp
  create_station_console if name == ''

  create_station!(name)
end

def show_station_trains
  puts 'station name'

  station_name = gets.chomp

  if !@stations.include?(station_name)
    puts 'there is no such a station'
  else
    @stations[station_name].show_trains
  end
end

# add search by route?
def show_stations
  puts @stations.keys.join(', ')
end

# create_station_console
# create_station_console
# show_station_trains
# show_stations
