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
@trains = {}

@train_types = { 'passenger' => PassengerTrain, 'cargo' => CargoTrain }
@carriage_types = { 'passenger' => PassengerCarriage, 'cargo' => CargoCarriage }

def create_train(type = nil)
  puts 'Enter train number'

  train_id = gets.chomp

  if @trains.keys.include?(train_id)
    puts 'there is already such a number'
    create_train(type)
  else
    return @train_types[type].new(train_id) if type

    puts 'Choose train type (enter index'

    type_index = input_index(@train_types.keys)
    type = @train_types.keys[type_index]
    train = @train_types[type].new(train_id)

    @trains[train.id] = train
    puts 'Enter A if you add route to train'

    choice = gets.chomp.downcase
    add_route_to_train(train) if choice == 'a'
  end
end

def input_index(array)
  array.each.with_index(1) do |item, index|
    puts "\t#{index}. #{item}"
  end

  choice = gets.chomp.to_i - 1
  choice.between?(0, array.size - 1) ? choice : input_index(array)
end

def add_route_to_train(train = nil)
  if @routes.empty?
    puts 'there is no routes'
  elsif @trains.empty?
    puts 'there is no trains'
  else
    route = find_route
    train ||= find_train

    train.add_route = route
    train
  end
end

def find_train
  puts 'Choose train by the index'

  str_trains = @trains.values.map(&:info)
  train_index = input_index(str_trains)

  @trains.values[train_index]
end

def move_train
  train = find_train
  move_train_process(train)
end

def move_train_process(train)
  puts 'enter F to move train forwards, B - backwards or X to exit'

  choice = gets.chomp.downcase

  case choice
  when 'f'
    train.to_next_station
  when 'b'
    train.to_previous_station
  when 'x'
    return
  else
    move_train_process(train)
  end
  move_train_process(train)
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

  if @stations.keys.include?(name)
    puts 'there is already such a station'
    create_station_console
  else
    create_station(name)
  end
end

def show_station_trains
  if @stations.empty?
    puts 'there is no stations'
    return
  end

  puts 'enter index of station or X to exit'

  station_index = input_index(@stations.keys)
  @stations.values[station_index.to_i].show_trains
end

# add search by route?
def show_stations
  @stations.keys.each { |name| puts name }
end

def show_routes
  @routes.each { |r| puts r.show_stations }
end

def create_route
  puts 'add first station'
  first_station = choose_station

  puts 'add last station'
  last_station = choose_station

  route = Route.new(first_station, last_station)

  add_station_console(route)
  add_route(route)
end

def choose_station
  if @stations.size <= 1
    puts 'there is no stations'
    return
  end

  puts 'enter index of station or X to exit'

  station_index = input_index(@stations.keys)
  @stations.values[station_index]
end

def add_route(route)
  if @routes.any? { |r| r.station_list == route.station_list }
    puts 'there is already such a route'
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

def update_route
  if @routes.empty?
    puts 'there is no routes'
    return
  end

  route = find_route
  update_by_type(route)
end

def find_route
  puts 'Choose route by the index'

  str_routes = @routes.map { |r| r.station_list.join(', ') } # TODO
  route_index = input_index(str_routes)

  @routes[route_index]
end

def delete_station_console(route)
  puts "enter station to delete:\n#{route.show_stations}"
  choice = gets.chomp.downcase

  delete_station_console(route) unless route.stations.any? { |s| s.name == choice }
  route.delete_station(@stations[choice])
end

def update_by_type(route)
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
    update_by_type(route)
  end
  update_by_type(route)
end

def create_carriage
  puts 'enter carriage type'

  type_index = input_index(@carriage_types.keys)
  type = @carriage_types.keys[type_index]
  @carriage_types[type].new
end

def manage_carriages
  train = find_train
  manage_carriages_process(train)
end

def manage_carriages_process(train)
  puts 'enter A to add carriage, D to remove or X to exit'

  choice = gets.chomp.downcase

  case choice
  when 'a'
    train.add_carriage(create_carriage)
  when 'd'
    train.remove_carriage
  when 'x'
    return
  else
    manage_carriages_process(train)
  end
  manage_carriages_process(train)
end

def station_management
  puts "Enter C to create station,\n" \
  "T to show trains on station,\n" \
  'A to show all stations or X to exit'

  choice = gets.chomp.downcase

  case choice
  when 'c'
    create_station_console
  when 't'
    show_station_trains
  when 'a'
    show_stations
  when 'x'
    return
  else
    station_management
  end
  station_management
end

def route_management
  puts "Enter C to create route, U to update route\n" \
  "R - to show all routes\n or X to exit"

  choice = gets.chomp.downcase

  case choice
  when 'c'
    create_route
  when 'u'
    update_route
  when 'r'
    show_routes
  when 'x'
    return
  else
    route_management
  end
  route_management
end

def train_management
  puts "Enter C to create train, A to add route\n" \
  "U - to change carriages, M - to move train\n" \
  'or X to exit'

  choice = gets.chomp.downcase

  case choice
  when 'c'
    create_train
  when 'a'
    add_route_to_train
  when 'u'
    manage_carriages
  when 'm'
    move_train
  when 'x'
    return
  else
    train_management
  end
  train_management
end

def start
  puts "Enter S to go to Station Management,\n" \
  "R - to Route Management, T - to Train management\n" \
  'or X to exit'

  choice = gets.chomp.downcase

  case choice
  when 's'
    station_management
  when 'r'
    route_management
  when 't'
    train_management
  when 'x'
    return
  else
    start
  end
  start
end

# start
