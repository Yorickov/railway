class RouteService < Service
  attr_reader :route_repo, :station_repo

  def initialize(options)
    @route_repo = options[:route_repo]
    @station_repo = options[:station_repo]
    @entity = options[:entity]
  end

  def create_route
    puts 'add first station'
    first_station = choose_station

    puts 'add last station'
    last_station = choose_station

    route = @entity.new(first_station, last_station)
    add_station_console(route)
    add_route(route)
  end

  def show_routes
    route_repo.data.each { |r| puts r.show_stations }
  end

  def choose_station
    if station_repo.data.size <= 1
      puts 'there is no stations'
      return
    end

    puts 'enter index of station or X to exit'

    station_index = input_index(station_repo.stations_list)
    station_repo.data[station_index]
  end

  def add_station_console(route)
    puts 'enter Y to add station or N to exit'

    choice = gets.chomp.downcase
    return if choice == 'n'

    route.add_station(choose_station) if choice == 'y' # position?
    add_station_console(route)
  end

  def add_route(route)
    if route_repo.data.any? { |r| r.station_list == route.station_list }
      puts 'there is already such a route'
    else
      route_repo.save(route)
    end
  end

  def update_route
    if route_repo.data.empty?
      puts 'there is no routes'
      return
    end

    route = find_route
    update_by_type(route)
  end

  def find_route
    puts 'Choose route by the index'

    str_routes = route_repo.data.map { |r| r.station_list.join(', ') } # TODO
    route_index = input_index(str_routes)

    route_repo.find_by_index(route_index)
  end

  def delete_station_console(route)
    puts "enter station to delete:\n#{route.show_stations}"
    choice = gets.chomp.downcase

    delete_station_console(route) unless route.stations.any? { |s| s.name == choice }
    station_to_delete = station_repo.data.find { |s| s.name == choice }
    route.delete_station(station_to_delete)
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
end
