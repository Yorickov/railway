require 'route'
require 'station'
require 'train'
require 'passenger_train'
require 'cargo_train'
require 'carriage'
require 'passenger_carriage'
require 'cargo_carriage'

describe Train, '#speed_methods' do
  before(:context) do
    @cargo_train = CargoTrain.new('1')
  end

  it 'speed up' do
    @cargo_train.speed_up
    expect(@cargo_train.speed).to eq(1)
  end

  it 'slow down' do
    @cargo_train.slow_down
    expect(@cargo_train.speed).to eq(0)
  end
end

describe Train, '#carriage_methods' do
  before(:context) do
    @passenger_train = PassengerTrain.new('1')
    @passenger_carriage = PassengerCarriage.new
    @cargo_carriage = CargoCarriage.new
  end

  it 'add carriage' do # edit
    @passenger_train.add_carriage(@passenger_carriage)
    expect(@passenger_train.carriages_count).to eq(1)
  end

  it 'add wrong carriage' do # edit
    expect { @passenger_train.add_carriage(@cargo_carriage) }
      .to output("wrong carriage\n")
      .to_stdout
  end

  it 'remove carriage' do # edit
    @passenger_train.remove_carriage
    expect(@passenger_train.carriages_count).to eq(0)
  end
end

describe Train, '#move_methods' do
  before(:context) do
    @cargo_rain = CargoTrain.new('1')
    @first_station = Station.new('Boston')
    @last_station = Station.new('NY')
    @route = Route.new(@first_station, @last_station)
  end

  it 'add route' do
    @cargo_rain.add_route(@route)
    expect(@cargo_rain.current_station.name).to eq('Boston')
  end

  it 'to next station' do
    @cargo_rain.to_next_station
    expect(@cargo_rain.current_station.name).to eq('NY')
  end

  it 'to next station' do
    @cargo_rain.to_next_station
    expect(@cargo_rain.to_next_station).to be_nil
  end

  it 'to previous station' do
    @cargo_rain.to_previous_station
    expect(@cargo_rain.current_station.name).to eq('Boston')
  end

  it 'to previous station' do
    expect(@cargo_rain.to_previous_station).to be_nil
  end
end
