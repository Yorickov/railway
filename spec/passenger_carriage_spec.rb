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
    @passenger_carriage.number = 3
    @passenger_carriage.take_seat

    expected = 'No 3, type: passenger, seats: free - 9, occupied: 1'
    expect(@passenger_carriage.info).to eq(expected)
  end
end
