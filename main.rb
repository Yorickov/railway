require_relative 'lib/entities/station'
require_relative 'lib/entities/route'

require_relative 'lib/entities/train'
require_relative 'lib/entities/passenger_train'
require_relative 'lib/entities/cargo_train'

require_relative 'lib/entities/carriage'
require_relative 'lib/entities/passenger_carriage'
require_relative 'lib/entities/cargo_carriage'

require_relative 'lib/repos/repo'
require_relative 'lib/repos/station_repo'
require_relative 'lib/repos/route_repo'
require_relative 'lib/repos/train_repo'

require_relative 'lib/services/service'
require_relative 'lib/services/station_service'
require_relative 'lib/services/route_service'
require_relative 'lib/services/train_service'

require_relative 'lib/manager'

train_repo = TrainRepo.new

station_options = { station_klass: Station }

route_options = {
  route_klass: Route,
  station_klass: Station
}

train_options = {
  train_repo: train_repo,
  entity_train: Train,
  entity_carriage: Carriage,
  route_klass: Route
}

station_service = StationService.new(station_options)
route_service = RouteService.new(route_options)
train_service = TrainService.new(train_options)

manager_options = {
  station_service: station_service,
  route_service: route_service,
  train_service: train_service
}

manager = Manager.new(manager_options)
manager.start
