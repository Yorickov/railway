require_relative 'lib/station'
require_relative 'lib/route'

require_relative 'lib/train'
require_relative 'lib/passenger_train'
require_relative 'lib/cargo_train'

require_relative 'lib/carriage'
require_relative 'lib/passenger_carriage'
require_relative 'lib/cargo_carriage'

require_relative 'lib/repos/repo'
require_relative 'lib/repos/station_repo'
require_relative 'lib/repos/route_repo'
require_relative 'lib/repos/train_repo'

require_relative 'lib/services/service.rb'
require_relative 'lib/services/station_service.rb'
require_relative 'lib/services/route_service.rb'

station_repo = StationRepo.new
route_repo = RouteRepo.new

station_options = { repo: station_repo, entity: Station }
route_options = { route_repo: route_repo, station_repo: station_repo, entity: Route }

station_service = StationService.new(station_options)
route_service = RouteService.new(route_options)

station_service.create_station_console
station_service.create_station_console
station_service.create_station_console
station_service.show_stations

route_service.create_route
route_service.show_routes

@stations = {}
@routes = []
@trains = {}

@train_types = { 'passenger' => PassengerTrain, 'cargo' => CargoTrain }
@carriage_types = { 'passenger' => PassengerCarriage, 'cargo' => CargoCarriage }

def create_train(type = nil) #----------ADD
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

def input_index(array) #----------ADD
  array.each.with_index(1) do |item, index|
    puts "\t#{index}. #{item}"
  end

  choice = gets.chomp.to_i - 1
  choice.between?(0, array.size - 1) ? choice : input_index(array)
end

def add_route_to_train(train = nil) #----------ADD
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

def find_train #----------ADD
  puts 'Choose train by the index'

  str_trains = @trains.values.map(&:info)
  train_index = input_index(str_trains)

  @trains.values[train_index]
end

def move_train
  train = find_train
  move_train_process(train)
end

def move_train_process(train) #----------ADD
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

def create_carriage #-------------------ADD
  puts 'enter carriage type'

  type_index = input_index(@carriage_types.keys)
  type = @carriage_types.keys[type_index]
  @carriage_types[type].new
end

def manage_carriages
  train = find_train
  manage_carriages_process(train)
end

def manage_carriages_process(train) #-------------------ADD
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

# def station_management
#   puts "Enter C to create station,\n" \
#   "T to show trains on station,\n" \
#   'A to show all stations or X to exit'

#   choice = gets.chomp.downcase

#   case choice
#   when 'c'
#     create_station_console
#   when 't'
#     show_station_trains
#   when 'a'
#     show_stations
#   when 'x'
#     return
#   else
#     station_management
#   end
#   station_management
# end

# def route_management
#   puts "Enter C to create route, U to update route\n" \
#   "R - to show all routes\n or X to exit"

#   choice = gets.chomp.downcase

#   case choice
#   when 'c'
#     create_route
#   when 'u'
#     update_route
#   when 'r'
#     show_routes
#   when 'x'
#     return
#   else
#     route_management
#   end
#   route_management
# end

# def train_management
#   puts "Enter C to create train, A to add route\n" \
#   "U - to change carriages, M - to move train\n" \
#   'or X to exit'

#   choice = gets.chomp.downcase

#   case choice
#   when 'c'
#     create_train
#   when 'a'
#     add_route_to_train
#   when 'u'
#     manage_carriages
#   when 'm'
#     move_train
#   when 'x'
#     return
#   else
#     train_management
#   end
#   train_management
# end

# def start
#   puts "Enter S to go to Station Management,\n" \
#   "R - to Route Management, T - to Train management\n" \
#   'or X to exit'

#   choice = gets.chomp.downcase

#   case choice
#   when 's'
#     station_management
#   when 'r'
#     route_management
#   when 't'
#     train_management
#   when 'x'
#     return
#   else
#     start
#   end
#   start
# end

# start
