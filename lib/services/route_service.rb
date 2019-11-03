class RouteService < Service
  def initialize(options)
    @route_repo = options[:route_repo]
    @station_klass = options[:station_klass]
    @route_klass = options[:route_klass]
  end

  def create_route
    puts 'add first station'
    first_station = choose_station

    puts 'add last station'
    last_station = choose_station

    route = @route_klass.new(first_station, last_station)
    add_station_console(route)
    add_route(route)
  end

  def show_routes
    route_repo.data.each { |r| puts r.show_stations }
  end

  def update_route
    if route_repo.data.empty?
      puts 'there is no routes'
      return
    end

    route = find_route
    update_by_type(route)
  end

  private

  attr_reader :route_repo, :station_klass

  def choose_station
    if station_klass.all.size <= 1
      puts 'there is no stations'
      return
    end

    puts 'enter index of station or X to exit'

    station_index = input_index(station_klass.stations_list)
    station_klass.all[station_index]
  end

  def add_route(route)
    if route_repo.data.any? { |r| r.show_stations == route.show_stations }
      puts 'there is already such a route'
    else
      route_repo.save(route)
    end
  end

  def add_station_console(route)
    puts 'enter Y to add station or N to exit'

    choice = gets.chomp.downcase
    return if choice == 'n'

    route.add_station(choose_station) if choice == 'y' # position?
    add_station_console(route)
  end

  def delete_station_console(route)
    puts "enter station to delete:\n#{route.show_stations}"
    choice = gets.chomp.downcase

    delete_station_console(route) unless route.stations.any? { |s| s.name == choice }
    station_to_delete = station_klass.find(choice)
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

  def find_route
    puts 'Choose route by the index'

    str_routes = route_repo.data.map(&:show_stations)
    route_index = input_index(str_routes)

    route_repo.find_by_index(route_index)
  end
end
