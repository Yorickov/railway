class RouteService < Service
  def create_route_console
    if station_klass.all.empty?
      puts 'there is no stations to create route'
      return
    end

    puts 'add first station'
    first_station = choose_station
    return unless first_station

    puts 'add last station'
    last_station = choose_station
    return unless last_station

    route = create_route(first_station, last_station)
    add_station_console(route)
  end

  def show_routes
    if route_klass.all.empty?
      puts 'there is no routes'
      return
    end

    route_klass.all.each { |r| puts r.show_stations }
  end

  def update_route
    route = find_route
    unless route
      puts 'there is no such a route'
      return
    end

    update_by_type(route)
  end

  private

  attr_reader :route_klass, :station_klass

  def create_route(first_station, last_station)
    @route_klass.new(first_station, last_station)
  end

  def add_station_console(route)
    puts 'enter Y to add station or any key to exit'

    choice = gets.chomp.downcase
    return if choice != 'y'

    unless route.add_station(choose_station) # position?
      puts 'This station is already in route'
      return
    end

    add_station_console(route)
  end

  def choose_station
    if station_klass.all.empty?
      puts 'there is no stations, create the one firs'
      return
    end

    station_index = input_index(station_klass.stations_list, 'station')
    station_klass.all[station_index] if station_index
  end

  def update_by_type(route)
    puts 'enter A to add station, D to delete S to show route or X to exit'

    choice = gets.chomp.downcase

    case choice
    when 'a'
      add_station_console(route)
    when 'd'
      delete_station_console(route)
    when 's'
      puts route.show_stations
    when 'x'
      return
    else
      update_by_type(route)
    end
    update_by_type(route)
  end

  def delete_station_console(route)
    puts "enter station to delete:\n#{route.show_stations}"
    choice = gets.chomp.downcase

    unless route.stations.any? { |s| s.name == choice }
      delete_station_console(route)
    end

    station_to_delete = station_klass.find(choice)

    deleted_station = route.delete_station(station_to_delete)
    puts 'station can not be removed' unless deleted_station
  end
end
