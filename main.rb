require_relative 'lib/station'
require_relative 'lib/route'

require_relative 'lib/train'
require_relative 'lib/passenger_train'
require_relative 'lib/cargo_train'

require_relative 'lib/carriage'
require_relative 'lib/passenger_carriage'
require_relative 'lib/cargo_carriage'

@stations = {}
@routes = []

def input_index(array)
  array.each.with_index(1) do |item, index|
    puts 'Enter index' \
        "\t#{index}. #{item}"
  end

  choice = gets.chomp.to_i - 1
  choice.between?(0, array.size - 1) ? choice : input_index(array)
end

def create_station(name)
  station = Station.new(name)
  @stations[name] = station
  station
end

def create_station_console
  puts 'enter station name'

  name = gets.chomp
  create_station_console if name == ''

  create_station(name)
end

def show_station_trains
  puts 'enter index of station or X to exit'

  station_index = input_index(@stations.keys)
  return unless station_index

  @stations.values[station_index.to_i].show_trains
end

# add search by route?
def show_stations
  puts @stations.keys.join(', ')
end

def create_route
  puts 'create first station'
  first_station = create_station_console

  puts 'create last station'
  last_station = create_station_console

  route = Route.new(first_station, last_station)

  add_station_console(route)
  add_route(route)
end

def add_route(route)
  if @routes.any? { |r| r.to_hash.keys == route.to_hash.keys }
    puts 'there is already such a route'
    puts route.show_stations
  else
    @routes.push(route)
  end
end

def add_station_console(route)
  puts 'enter Y to add station or N to exit'
  choice = gets.chomp.downcase
  return if choice == 'n'

  route.add_station(create_station_console) if choice == 'y' # position?
  add_station_console(route)
end

def delete_station_console(route)
  puts "enter station to delete:\n#{route.show_stations}"
  choice = gets.chomp.downcase

  delete_station_console(route) unless route.stations.any? { |s| s.name == choice }
  route.delete_station(@stations[choice])
end

def find_route
  puts 'Choose route by the index'

  str_routes = @routes.map { |r| r.to_hash.keys.join(', ') } # TODO
  route_index = input_index(str_routes)
  return unless route_index

  @routes[route_index]
end

def choice_update_type(route)
  puts 'enter A to add station, D to delete S to show station or X to exit'
  choice = gets.chomp.downcase
  return if choice == 'x'

  case choice
  when 'a'
    add_station_console(route)
  when 'd'
    delete_station_console(route)
  when 's'
    puts route.show_stations
  else
    choice_update_type(route)
  end
  choice_update_type(route)
end

def update_route
  if @routes.empty?
    puts 'there is no routes'
    return
  end

  route = find_route
  choice_update_type(route)
end

# create_station_console
# create_station_console
# show_station_trains
# show_stations

create_route
create_route

update_route
p @routes
p @stations
