require 'station'
require 'train'
require 'passenger_train'

describe Station do
  before(:context) do
    @station = Station.new('Boston')
    @passenger_train = PassengerTrain.new('1')
    @cargo_train = CargoTrain.new('2')
  end

  it 'add train' do
    @station.add_train(@passenger_train)
    @station.add_train(@cargo_train)
    expect(@station.trains).to include(@passenger_train, @cargo_train)
  end

  it 'show trains' do
    expect { @station.show_trains }.to output("1\n2\n").to_stdout
  end

  it 'show passenger trains' do
    expect { @station.show_trains_by_type('passenger') }
      .to output("1\n").to_stdout
  end

  it 'show cargo trains' do
    expect { @station.show_trains_by_type('cargo') }
      .to output("2\n").to_stdout
  end

  it 'send train' do
    @station.send_train(@cargo_train)
    expect(@station.trains.size).to eq(1)
  end
end
