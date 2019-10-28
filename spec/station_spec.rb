require 'station'
require 'train'

RSpec.describe Station do
  before(:context) do
    @station = Station.new('Boston')
    @train = Train.new('1', 'passenger', 3)
  end

  describe 'methods' do
    it 'add train' do
      @station.add_train(@train)
      expect(@station.trains).to include(@train)
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
      @station.send_train(@train)
      expect(@station.trains.length).to eq(0)
    end
  end
end
