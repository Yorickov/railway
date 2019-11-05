class Manager
  def initialize(options)
    @station_service = options[:station_service]
    @route_service = options[:route_service]
    @train_service = options[:train_service]
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

  private

  def station_management
    puts "Enter C to create station,\n" \
    "T to show trains on station,\n" \
    'A to show all stations or X to exit'

    choice = gets.chomp.downcase

    case choice
    when 'c'
      @station_service.create_station_console
    when 't'
      @station_service.show_station_trains
    when 'a'
      @station_service.show_stations
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
      @route_service.create_route
    when 'u'
      @route_service.update_route
    when 'r'
      @route_service.show_routes
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
      @train_service.create_train_console
    when 'a'
      @train_service.add_route_to_train
    when 'u'
      @train_service.manage_carriages
    when 'm'
      @train_service.move_train
    when 'x'
      return
    else
      train_management
    end
    train_management
  end
end
