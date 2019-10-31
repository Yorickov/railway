require 'station'
require 'route'

require 'train'
require 'passenger_train'
require 'cargo_train'

require 'carriage'
require 'passenger_carriage'
require 'cargo_carriage'

require_relative '../main'

describe 'station managment' do
  it 'create station' do
    @stations = {}
    create_station('Boston')
    expect(@stations['Boston'].name).to eq('Boston')
  end
end
