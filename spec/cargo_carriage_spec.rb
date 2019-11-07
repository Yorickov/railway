require 'entities/carriage'
require 'entities/cargo_carriage'

describe CargoCarriage do
  it 'validation' do
    expect { CargoCarriage.new('') }
      .to raise_error('You must input smth.')
    expect { CargoCarriage.new('6666') }
      .to raise_error('Should be from 1 to 1000')
  end

  it 'methods' do
    @cargo_carriage = CargoCarriage.new('10')
    @cargo_carriage.number = 2
    @cargo_carriage.take_volume(3)

    expected = 'No 2, type: cargo, volume: free - 7, occupied: 3'
    expect(@cargo_carriage.info).to eq(expected)
  end
end
