require 'station'
require 'train'
require 'passenger_train'

describe Station do
  before(:context) do
    @station = Station.new('Boston')
    @passenger_train = PassengerTrain.new('1')
  end

  describe 'passenger methods' do
    it 'add train' do
      @station.add_train(@passenger_train)
      expect(@station.trains).to include(@passenger_train)
    end

    it 'show trains' do
      expect { @station.show_trains }
        .to output("1\n")
        .to_stdout
    end

    it 'show trains by type' do
      expect { @station.show_trains_by_type('passenger') }
        .to output("1\n")
        .to_stdout
    end

    it 'send train' do
      @station.send_train(@passenger_train)
      expect(@station.trains.size).to eq(0)
    end
  end
end
