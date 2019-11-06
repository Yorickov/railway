require 'entities/route'
require 'entities/station'
require 'entities/train'
require 'entities/passenger_train'
require 'entities/cargo_train'
require 'entities/carriage'
require 'entities/passenger_carriage'
require 'entities/cargo_carriage'

describe Train, '#speed_methods' do
  before(:context) do
    @cargo_train = CargoTrain.new('121-22')
  end

  it 'speed up' do
    @cargo_train.speed_up
    expect(@cargo_train.speed).to eq(1)
  end

  it 'slow down' do
    @cargo_train.slow_down
    expect(@cargo_train.speed).to eq(0)
  end

  it 'all trains' do
    expect(Train.trains_list).to include('121-22')
  end

  it 'find train' do
    expect(Train.find('121-22').number).to eq('121-22')
  end
end

describe Train, '#carriage_methods' do
  before(:context) do
    @passenger_train = PassengerTrain.new('1aw-23')
    @passenger_carriage = PassengerCarriage.new('33')
    @cargo_train = CargoTrain.new('123-23')
    @cargo_carriage1 = CargoCarriage.new('33')
    @cargo_carriage2 = CargoCarriage.new('31')
  end

  it 'validate' do
    expect { PassengerTrain.new('') }
      .to raise_error('You must input smth.')
    expect { PassengerTrain.new('grogsf') }
      .to raise_error('Name has invalid format')
    # expect { PassengerTrain.new('Boston') }
    #   .to raise_error('there is such a name')
  end

  it 'add carriage' do # edit
    @passenger_train.add_carriage(@passenger_carriage)
    expect(@passenger_train.carriages_count).to eq(1)
  end

  it 'add wrong carriage' do # edit
    expect { @passenger_train.add_carriage(@cargo_carriage1) }
      .to output("wrong carriage\n")
      .to_stdout
  end

  it 'iter passenger carriages' do
    @passenger_train.iter_carriages(&:take_seat)
    expect(@passenger_train.carriages[0].occupied_seats).to eq(1)
  end

  it 'iter cargo carriages' do
    @cargo_train.add_carriage(@cargo_carriage1)
    @cargo_train.add_carriage(@cargo_carriage2)

    @cargo_train.iter_carriages { |c| c.take_volume(2) }
    expect(@cargo_train.carriages[1].free_volume).to eq(29)
  end

  it 'remove carriage' do # edit
    @passenger_train.remove_carriage
    expect(@passenger_train.carriages_count).to eq(0)
  end
end

describe Train, '#move_methods' do
  before(:context) do
    @cargo_train = CargoTrain.new('121-rt')
    @first_station = Station.new('Chicago')
    @last_station = Station.new('SF')
    @route = Route.new(@first_station, @last_station)
  end

  it 'add route' do
    @cargo_train.add_route = @route
    expect(@cargo_train.current_station.name).to eq('Chicago')
  end

  it 'to next station' do
    @cargo_train.to_next_station
    expect(@cargo_train.current_station.name).to eq('SF')
  end

  it 'to next station' do
    @cargo_train.to_next_station
    expect(@cargo_train.to_next_station).to be_nil
  end

  it 'to previous station' do
    @cargo_train.to_previous_station
    expect(@cargo_train.current_station.name).to eq('Chicago')
  end

  it 'to previous station' do
    expect(@cargo_train.to_previous_station).to be_nil
  end
end
