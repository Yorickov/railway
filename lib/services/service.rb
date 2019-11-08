class Service
  def initialize(options)
    @station_klass = options[:station_klass]
    @train_klass = options[:train_klass]
    @carriage_klass = options[:carriage_klass]
    @route_klass = options[:route_klass]
  end

  protected

  def input_index(array, name)
    puts "enter index of #{name} or X to exit"

    array.each.with_index(1) { |item, index| puts "\t#{index}. #{item}" }
    choice = gets.chomp
    return if choice.downcase == 'x'

    index = choice.to_i - 1
    index.between?(0, array.size - 1) ? index : input_index(array, name)
  end

  def find_station
    return if station_klass.all.empty?

    station_index = input_index(station_klass.stations_list, 'station')
    station_klass.all[station_index.to_i] if station_index
  end

  def find_route
    return if route_klass.all.empty?

    str_routes = route_klass.all.map(&:show_stations)
    route_index = input_index(str_routes, 'route')

    route_klass.all[route_index] if route_index
  end

  def find_train
    return if train_klass.all.empty?

    str_trains = train_klass.all.values.map(&:info)
    train_index = input_index(str_trains, 'train')

    train_klass.all.values[train_index] if train_index
  end
end
