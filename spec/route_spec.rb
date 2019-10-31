require 'route'
require 'station'

describe Route do
  before(:context) do
    @first_station = Station.new('Boston')
    @last_station = Station.new('San Antonio')
    @new_station = Station.new('Dallas')
    @route = Route.new(@first_station, @last_station)
  end

  context 'right' do
    it 'add station' do
      @route.add_station(@new_station)
      expect(@route.stations).to include(@new_station)
    end

    it 'show stations' do
      expect(@route.show_stations).to eq('Boston - Dallas - San Antonio')
    end

    it 'delete station' do
      @route.delete_station(@new_station)
      expect(@route.stations).not_to include(@new_station)
    end
  end

  context 'wrong' do
    it 'delete first station' do
      expect { @route.delete_station(@first_station) }
        .to output("station can not be removed\n")
        .to_stdout
    end

    it 'delete last station' do
      expect { @route.delete_station(@last_station) }
        .to output("station can not be removed\n")
        .to_stdout
    end
  end
end
