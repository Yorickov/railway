require 'entities/train'
require 'entities/passenger_train'
require 'entities/cargo_train'
require 'entities/carriage'
require 'entities/passenger_carriage'
require 'entities/cargo_carriage'
require 'modules/company'

describe Company do
  it 'Train' do
    passenger_train = PassengerTrain.new('12322')
    passenger_train.company_name = 'Boogy'
    expect(passenger_train.company_name).to eq('Boogy')
  end

  it 'Company' do
    passenger_carriage = PassengerCarriage.new('4')
    passenger_carriage.company_name = 'Xeon'
    expect(passenger_carriage.company_name).to eq('Xeon')
  end
end
