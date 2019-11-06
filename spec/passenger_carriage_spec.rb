require 'entities/carriage'
require 'entities/passenger_carriage'

describe PassengerCarriage do
  it 'validation' do
    expect { PassengerCarriage.new('') }
      .to raise_error('You must input smth. digitally')
    expect { PassengerCarriage.new('666') }
      .to raise_error('Should be from 1 to 100')
  end

  it 'methods' do
    @passenger_carriage = PassengerCarriage.new('10')
    @passenger_carriage.take_seat

    expect(@passenger_carriage.free_seats).to eq(9)
    expect(@passenger_carriage.occupied_seats).to eq(1)
    expect(@passenger_carriage.seats[0]).to be_truthy
  end
end
