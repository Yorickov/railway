class TrainService < Service
  def initialize(options)
    @train_klass = options[:train_klass]
    @carriage_klass = options[:carriage_klass]
    @route_klass = options[:route_klass]
  end

  def create_train_console
    type_index = input_index(@train_klass.types.keys, 'train type')
    return unless type_index

    begin
      puts 'Enter train number or X to exit'

      train_number = gets.chomp
      return if train_number.downcase == 'x'

      train = create_train(train_number, type_index)
    rescue => e
      puts e.message
      retry
    end
    puts "Created #{train.info}"
    puts 'Enter A if you add route to train or any key to exit'

    choice = gets.chomp.downcase
    add_route_to_train(train) if choice == 'a'
  end

  def add_route_to_train(train = nil)
    route = find_route
    unless route
      puts 'there is no routes'
      return
    end

    train ||= find_train
    unless train
      puts 'there is no trains'
      return
    end

    train.add_route = route
    train
  end

  def move_train
    train = find_train
    unless train
      puts 'there is no trains'
      return
    end

    move_train_process(train)
  end

  def manage_carriages
    train = find_train
    unless train
      puts 'there is no trains'
      return
    end

    manage_carriages_process(train)
  end

  private

  attr_reader :train_klass, :route_klass

  def create_train(number, type_index)
    type = @train_klass.types.keys[type_index]
    @train_klass.types[type].new(number)
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

  def create_carriage
    type_index = input_index(@carriage_klass.types.keys, 'carriage type')
    return unless type_index

    type = @carriage_klass.types.keys[type_index]
    @carriage_klass.types[type].new
  end
end
