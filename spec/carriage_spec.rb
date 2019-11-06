require 'entities/carriage'
require 'entities/passenger_carriage'
require 'entities/cargo_carriage'

describe 'carriage classes type-checking' do
  it 'passenger' do
    @passenger_carriage = PassengerCarriage.new('5')
    expect(@passenger_carriage.type).to eq 'passenger'
  end

  it 'cargo' do
    @cargo_carriage = CargoCarriage.new
    expect(@cargo_carriage.type).to eq 'cargo'
  end
end
