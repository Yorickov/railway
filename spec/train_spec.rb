require 'route'
require 'station'
require 'train'
require 'carriage'
require 'passenger_carriage'
require 'cargo_carriage'

describe Route, '#light_methods' do
  before(:context) do
    @train = Train.new('1', 'passenger')
    @passenger_carriage = PassengerCarriage.new
  end

  it 'speed up' do
    @train.speed_up
    expect(@train.speed).to eq(1)
  end

  it 'slow down' do
    @train.slow_down
    expect(@train.speed).to eq(0)
  end

  it 'add carriage' do
    @train.add_carriage(@passenger_carriage)
    expect(@train.carriages).to include(@passenger_carriage)
  end

  it 'remove carriage' do
    @train.remove_carriage
    expect(@train.carriages.size).to eq(0)
  end
end

describe Route, '#hard_methods' do
  before(:context) do
    @train = Train.new('1', 'passenger')
    @first_station = Station.new('Boston')
    @last_station = Station.new('NY')
    @route = Route.new(@first_station, @last_station)
  end

  it 'add route' do
    @train.add_route(@route)
    expect(@train.current_station.name).to eq('Boston')
  end

  it 'next station' do
    expect(@train.next_station.name).to eq('NY')
  end

  it 'to next station' do
    @train.to_next_station
    expect(@train.current_station.name).to eq('NY')
  end

  it 'previous station' do
    expect(@train.previous_station.name).to eq('Boston')
  end

  it 'to previous station' do
    @train.to_previous_station
    expect(@train.current_station.name).to eq('Boston')
  end
end

describe Route, '#wrong hard_methods' do
  before(:context) do
    @train = Train.new('1', 'passenger')
    @first_station = Station.new('Boston')
    @last_station = Station.new('NY')
    @route = Route.new(@first_station, @last_station)
    @train.add_route(@route)
  end

  it 'previous station' do
    expect { @train.previous_station }
      .to output("no more stations\n")
      .to_stdout
  end

  it 'next station' do
    @train.to_next_station
    expect { @train.next_station }
      .to output("no more stations\n")
      .to_stdout
  end
end
