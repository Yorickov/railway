require 'entities/station'
require 'entities/route'

require 'entities/train'
require 'entities/passenger_train'
require 'entities/cargo_train'

require 'modules/instance_counter'

describe InstanceCounter do
  it 'all in' do
    CargoTrain.new('qw1-ww')
    CargoTrain.new('2wq-33')
    @station1 = Station.new('Phoenix')
    @station2 = Station.new('LA')
    Route.new(@station1, @station2)

    expect(CargoTrain.instances).to eq(2)
    expect(Station.instances).to eq(2)
    expect(Route.instances).to eq(1)
    expect(Train.instances).to be_nil
  end
end
