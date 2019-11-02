require 'entities/station'
require 'entities/train'
require 'entities/passenger_train'
require 'entities/cargo_train'
require 'entities/route'

describe Station do
  before(:context) do
    @station = Station.new('Boston')
    @passenger_train = PassengerTrain.new('1')
    @cargo_train = CargoTrain.new('2')

    @first_station = Station.new('Boston')
    @last_station = Station.new('NY')
    @route = Route.new(@first_station, @last_station)

    @passenger_train.add_route = @route
    @cargo_train.add_route = @route
  end

  it 'add train' do
    @station.add_train(@passenger_train)
    @station.add_train(@cargo_train)
    expect(@station.trains).to include(@passenger_train, @cargo_train)
  end

  it 'show trains' do
    str = "Train No 1, type: passenger, Boston - NY\n" \
    "Train No 2, type: cargo, Boston - NY\n"
    expect { @station.show_trains }.to output(str).to_stdout
  end

  it 'show passenger trains' do
    expect { @station.show_trains_by_type('passenger') }
      .to output("Train No 1, type: passenger, Boston - NY\n").to_stdout
  end

  it 'show cargo trains' do
    expect { @station.show_trains_by_type('cargo') }
      .to output("Train No 2, type: cargo, Boston - NY\n").to_stdout
  end

  it 'send train' do
    @station.send_train(@cargo_train)
    expect(@station.trains.size).to eq(1)
  end
end
