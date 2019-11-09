require 'entities/carriage'
require 'entities/passenger_carriage'

describe PassengerCarriage do
  it 'validation' do
    expect { PassengerCarriage.new('0') }
      .to raise_error('Invalid format')
  end

  it 'methods' do
    @passenger_carriage = PassengerCarriage.new('10')
    @passenger_carriage.number = 3
    @passenger_carriage.take_seat

    expected = 'No 3, type: passenger, seats: free - 9, occupied: 1'
    expect(@passenger_carriage.info).to eq(expected)
  end
end
