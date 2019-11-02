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
require_relative 'lib/services/train_service.rb'

station_repo = StationRepo.new
route_repo = RouteRepo.new
train_repo = TrainRepo.new

station_options = { repo: station_repo, entity: Station }
route_options = { route_repo: route_repo, station_repo: station_repo, entity: Route }
train_options = { train_repo: train_repo, route_repo: route_repo, entity: Train }

station_service = StationService.new(station_options)
route_service = RouteService.new(route_options)
train_service = TrainService.new(train_options)

station_service.create_station_console
station_service.create_station_console
station_service.create_station_console
station_service.show_stations

route_service.create_route
route_service.show_routes

train_service.create_train
train_service.add_route_to_train
train_service.manage_carriages
train_service.move_train

@stations = {}
@routes = []
@trains = {}

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
