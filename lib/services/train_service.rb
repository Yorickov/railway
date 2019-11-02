class TrainService < Service
  def initialize(options)
    @train_repo = options[:train_repo]
    @route_repo = options[:route_repo]
    @entity_train = options[:entity_train]
    @entity_carriage = options[:entity_carriage]
  end

  def create_train
    puts 'Enter train number'

    train_id = gets.chomp

    if train_repo.trains_list.include?(train_id)
      puts 'there is already such a number'
      create_train
    else
      puts 'Choose train type (enter index'

      type_index = input_index(@entity_train.types.keys)
      type = @entity_train.types.keys[type_index]
      train = @entity_train.types[type].new(train_id)

      train_repo.save(train)
      puts 'Enter A if you add route to train'

      choice = gets.chomp.downcase
      add_route_to_train(train) if choice == 'a'
    end
  end

  def add_route_to_train(train = nil)
    if route_repo.data.empty?
      puts 'there is no routes'
    elsif train_repo.data.empty?
      puts 'there is no trains'
    else
      route = find_route
      train ||= find_train

      train.add_route = route
      train
    end
  end

  def move_train
    train = find_train
    move_train_process(train)
  end

  def manage_carriages
    train = find_train
    manage_carriages_process(train)
  end

  private

  attr_reader :train_repo, :route_repo

  def find_route
    puts 'Choose route by the index'

    str_routes = route_repo.data.map(&:show_stations)
    route_index = input_index(str_routes)

    route_repo.find_by_index(route_index)
  end

  def find_train
    puts 'Choose train by the index'

    str_trains = train_repo.data.map(&:info)
    train_index = input_index(str_trains)

    train_repo.find_by_index(train_index)
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
    puts 'enter carriage type'

    type_index = input_index(@entity_carriage.types.keys)
    type = @entity_carriage.types.keys[type_index]
    @entity_carriage.types[type].new
  end
end
