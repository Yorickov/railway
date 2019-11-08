require 'entities/station'
require 'entities/train'
require 'entities/passenger_train'
require 'entities/cargo_train'
require 'entities/route'

describe Station do
  before(:context) do
    @station = Station.new('Atlanta')
    @passenger_train = PassengerTrain.new('fre-tr')
    @cargo_train = CargoTrain.new('ub2-tr')

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

  it 'validate' do
    expect { Station.new('') }
      .to raise_error(RuntimeError, 'You must input smth.')
    expect { Station.new('tr_rtt') }
      .to raise_error(RuntimeError, 'Name has invalid format')
    expect { Station.new('Boston') }
      .to raise_error(RuntimeError, 'there is such a name')
  end

  it 'all stations' do
    expect(Station.all).to include(@station, @first_station, @last_station)
  end

  it 'find station' do
    expect(Station.find('Boston').name).to eq('Boston')
  end

  it 'show trains' do
    str = "Train No fre-tr, type: passenger, carriage amount: 0, Boston - NY\n" \
    "Train No ub2-tr, type: cargo, carriage amount: 0, Boston - NY\n"
    expect { @station.show_trains }.to output(str).to_stdout
  end

  it 'show passenger trains' do
    expect { @station.show_trains_by_type('passenger') }
      .to output("Train No fre-tr, type: passenger, carriage amount: 0, Boston - NY\n")
      .to_stdout
  end

  it 'show cargo trains' do
    expect { @station.show_trains_by_type('cargo') }
      .to output("Train No ub2-tr, type: cargo, carriage amount: 0, Boston - NY\n")
      .to_stdout
  end

  it 'send train' do
    @station.send_train(@cargo_train)
    expect(@station.trains).not_to include(@cargo_train)
  end
end
